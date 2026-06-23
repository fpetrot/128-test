#!/bin/python3

import csv
import os
import io
import sys
import shlex
import subprocess
import matplotlib.pyplot as plt
from pathlib import Path

DEFAULT_QEMU_ARGS = (
    "-nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -plugin /work/qemu-riscv128/build-elf128/contrib/plugins/libexeclog.so -d plugin -kernel"
)

TIMEOUT = 10

def _qemu_command(binary: Path) -> list[str]:
    qemu = os.environ.get("QEMU", "qemu-system-riscv64")
    qemu_args = os.environ.get("QEMU_ARGS", DEFAULT_QEMU_ARGS)
    return [qemu, *shlex.split(qemu_args), str(binary)]


def _run(cmd: list[str], timeout: int) -> subprocess.CompletedProcess[bytes]:
    return subprocess.run(
        cmd,
        capture_output=True,
        timeout=timeout,
    )

def _render_output(data: bytes) -> str:
    return data.decode("utf-8", errors="replace")

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} [binary]")
        exit(1)

    program = sys.argv[1]

    qemu_result = _run(_qemu_command(program), TIMEOUT)

    output = io.StringIO(_render_output(qemu_result.stderr))

    lines = csv.reader(output, skipinitialspace=True)

    instructions = [line[3].split()[0] for line in lines]
    counts = dict()

    # Set to False to wait for a no op before counting instructions
    started = True

    for line in instructions:
        if not started:
            started = line == "nop"
        else:
            if line in counts:
                counts[line] += 1
            else:
                counts[line] = 1

    counts = list(counts.items())
    counts.sort(key=lambda x: x[1], reverse=True)

    total_count = sum(x[1] for x in counts)

    print(f"Total instructions count: {total_count}")
    
    counts = counts[:30]

    fig, ax = plt.subplots(figsize=(len(counts) * 0.3, 6))

    labels, values = zip(*counts)
    x = range(len(labels))

    ax.bar(x, values, width=0.6)
    ax.set_xticks(x)
    ax.set_xticklabels(labels, rotation=90, fontsize=8, ha='center')

    plt.title("Instructions count (Top 30)")

    plt.grid(True, axis="y")

    plt.savefig("instructions_count.png", dpi=150)
    

main()
