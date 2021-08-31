#!/bin/env python3

"""
    Module that runs all prgchk tests in given directories.
"""

import glob
import os
import time
import argparse
from dataclasses import dataclass, field
from typing import List

from prgchk import TestStatus, run_test

color_available = False
try:
    import colorama
    from colorama import Fore, Style
    color_available = True
except ImportError:
    pass

DEFAULT_TEST_PATH="unit_tests"
DEFAULT_OUTPUT_DIR="out"

@dataclass
class CLIOptions:
    failOnError: bool = False
    verbose: bool = False
    directories: List[str] = field(default_factory=(lambda: [DEFAULT_TEST_PATH]))
    clean: bool = False
    clean_after: bool = False

def parse_args() -> CLIOptions:
    parser = argparse.ArgumentParser(description="Run multiple tests in a sequence")
    parser.add_argument("-f", "--failerr", action='store_true')
    parser.add_argument("-v", "--verbose", action='store_true')
    parser.add_argument("-c", "--clean", action='store_true')
    parser.add_argument("-C", "--clean-after", action='store_true')
    parser.add_argument("dirs", nargs='*')

    a = parser.parse_args()
    
    o = CLIOptions()
    o.failOnError = a.failerr
    o.clean = a.clean
    o.clean_after = a.clean_after
    if a.dirs is not None and a.dirs:
        o.directories = a.dirs
    if a.verbose is not None:
        o.verbose = a.verbose

    return o

def find_all_test_files(dirs: List[str]) -> List[str]:
    return list(set().union(*[[os.path.abspath(p) for p in glob.glob(os.path.join(dir, "test_*"), recursive=False)] for dir in dirs]))

def clean_output() -> int:
    cnt = 0
    for filename in glob.glob(os.path.join(DEFAULT_OUTPUT_DIR, '*')):
        os.remove(filename)
        cnt += 1
    return cnt

if __name__ == "__main__":
    if color_available:
        colorama.init()
    opts = parse_args()
    if opts is None:
        exit(1)

    if opts.clean:
        cnt = clean_output()
        print(f"Cleaned {cnt} files from {DEFAULT_OUTPUT_DIR}")
        exit(0)

    total = 0
    successes = 0

    tests = find_all_test_files(opts.directories)
    tests.sort(key=lambda x: os.path.splitext(os.path.basename(x))[0])

    print(f"Running {len(tests)} tests")
    start = time.time()
    for test_filename in tests:
        total += 1
        test_name = os.path.splitext(os.path.basename(test_filename))[0]
        print(f"\t{test_name} : ", end="")
        
        status = run_test(test_filename, silent = not opts.verbose)

        if color_available:
            if status == TestStatus.SUCCESS:
                print(Fore.GREEN, end="")
            elif status == TestStatus.CHECK_FAILURE:
                print(Fore.RED, end="")
            else:
                print(Fore.YELLOW, end="")
        print(status.name)
        if color_available:
            print(Fore.RESET, end="")
        if status == TestStatus.SUCCESS:
            successes += 1
        elif opts.failOnError:
            print(f"Test {test_name} failure. Aborting...")
            exit(1)
    end = time.time()
    elapsed = end - start

    print(f"{successes}/{total} ({successes / (total if total != 0 else 100) * 100}%) of tests succeeded")
    print(f"Time elapsed : {elapsed:.3f}s")
    if (successes != total):
        print("Run with prgchk to obtain more verbose execution for failed cases")

    if opts.clean_after:
        clean_output()