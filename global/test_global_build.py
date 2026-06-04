import os
import shlex
import subprocess
from pathlib import Path

import pytest

TESTS_ROOT = Path(__file__).resolve().parent
BUILD_DIR = (TESTS_ROOT / "build").resolve()

DEFAULT_QEMU_ARGS = (
    "-nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -kernel"
)

TIMEOUT = 3
EXPECTED_TIMEOUT = {"hang"}


def _qemu_command(binary: Path) -> list[str]:
    qemu = os.environ.get("QEMU", "qemu-system-riscv64")
    qemu_args = os.environ.get("QEMU_ARGS", DEFAULT_QEMU_ARGS)
    return [qemu, *shlex.split(qemu_args), str(binary)]


def _discover_programs() -> list[Path]:
    if not BUILD_DIR.exists():
        pytest.fail(
            f"Build directory not found: {BUILD_DIR}. Run `make -C global/global-tests`."
        )

    programs = sorted(
        path for path in BUILD_DIR.glob("*.x") if not path.name.endswith("-host.x")
    )
    if not programs:
        pytest.fail(
            f"No .x binaries found in {BUILD_DIR}. Run `make -C global/global-tests`."
        )

    return programs


def pytest_generate_tests(metafunc: pytest.Metafunc) -> None:
    if "program" not in metafunc.fixturenames:
        return

    programs = _discover_programs()
    metafunc.parametrize("program", programs, ids=[p.name for p in programs])


def _run(cmd: list[str], timeout: int) -> subprocess.CompletedProcess[bytes]:
    return subprocess.run(
        cmd,
        capture_output=True,
        timeout=timeout,
    )


def _render_output(data: bytes) -> str:
    return data.decode("utf-8", errors="replace")


def test_program_output_matches_reference(program: Path) -> None:
    try:
        qemu_result = _run(_qemu_command(program), TIMEOUT)
    except subprocess.TimeoutExpired as exc:
        if program.stem in EXPECTED_TIMEOUT:
            return
        stdout = _render_output(exc.output or b"")
        stderr = _render_output(exc.stderr or b"")
        pytest.fail(
            f"Timeout for {program.name} after {TIMEOUT}s.\n"
            f"stdout:\n{stdout}\n"
            f"stderr:\n{stderr}"
        )

    if program.stem in EXPECTED_TIMEOUT:
        pytest.fail(f"Expected timeout for {program.name}, but it completed.")
    assert qemu_result.returncode == 0, (
        f"QEMU failed for {program.name} (exit {qemu_result.returncode}).\n"
        f"stdout:\n{_render_output(qemu_result.stdout)}\n"
        f"stderr:\n{_render_output(qemu_result.stderr)}"
    )

    host_binary = program.with_name(f"{program.stem}-host.x")
    if host_binary.exists():
        host_result = _run([str(host_binary)], TIMEOUT)
        assert qemu_result.stdout.strip() == host_result.stdout.strip(), (
            f"Output mismatch for {program.name} vs host.\n"
            f"qemu stdout:\n{_render_output(qemu_result.stdout)}\n"
            f"host stdout:\n{_render_output(host_result.stdout)}\n"
            f"host exit code: {host_result.returncode}"
        )
        return

    expected_file = program.with_suffix(".expected")
    if not expected_file.exists():
        pytest.fail(
            f"Missing expected output for {program.name}: {expected_file} not found."
        )

    expected_output = expected_file.read_bytes()
    assert qemu_result.stdout == expected_output, (
        f"Output mismatch for {program.name} vs {expected_file.name}.\n"
        f"qemu stdout:\n{_render_output(qemu_result.stdout)}\n"
        f"expected:\n{_render_output(expected_output)}"
    )
