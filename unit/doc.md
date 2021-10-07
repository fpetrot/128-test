# PRGCHK Tests
This test framework uses specially formatted C comments in C code or in raw assembly code to perform runtime assertion checking. The assertions are tested by an external tool at runtime, so that a test for an instruction doesn't require many others.

## Checks
A check is added to a C program by inserting a single line C comment that starts with `prgchk` without a space.
Checks have the syntax `//prgchk <command> <arguments>`. Arguments are a list of whitespace-separated strings.

Example :
```c
//prgchk reg x1 == 10
```
The check is performed at runtime at the place at which the comment was placed in the code.

### Register check
This check verifies that a register's value verifies a certain condition in relation to a constant, and fails if it doesn't.
Warning: the check is performed on `gdb`'s natural length, so with a 64-bit system, testing 128-bit registers will only check the lower 64 bits. 
The first argument must be a valid register name, followed by a comparison operator, and the third argument must be an integer constant.

Valid comparison operators are :
| Name             | Operator |
|------------------|----------|
| Equals           | ==       |
| Not Equals       | !=       |
| Less Than        | <        |
| Greater Than     | >        |
| Less or Equal    | <=       |
| Greater or Equal | >=       |

#### Examples :
* `//prgchk reg t0 == 0x1234567890abcdef`
* `//prgchk reg t1 < 42` 

### Variable Check
This check verifies that a variable, that is, a value at a cetain memory location indicated by a label, fullfills a certain condition against an integer constant. The conditions are the same as those used in the `reg` check.

#### Examples :
* `//prgchk var toto == 0x1234567890abcdef`
* `//prgchk var age < 42` 

### Error Check
This check unconditionnally causes an error if the next line of code is executed. Since the check is placed on the next line of code, and not on a comment, care should be taken to insert a `nop` instruction after this check.

#### Example :
```asm
    li t0, 121
    li t1, 121
    beq t0, t1, noerror
    //prgchk err
    nop
noerror:
    // All good !
```

### GDB Condition check
This check verifies that an arbitrary GDB expression evaluates to true at this position in code, and fails otherwise.

#### Examples
* `//prgchk gdb $t0 == 0x123` is equivalent to `///prgchk reg t0 == 0x123`, but the error message will not be as clear

# Automatic unit tests
Tests are C or RISC-V assembly files that have a name starting in `test_` placed in the `unit_tests` directory by default. Simply run `prgchk_all.py` to execute every one of them in succession. 

One or more directories can be given as a positional argument to `prgchk_all` to run tests from those other directories.
Note that `prgchk_all` returns ` (100.0%) of tests succeeded` although it fails in certain situations, so the output should be analysed thouroughly.
One simple solution at first, e.g.:
```
./prgchk_all.py unit_tests_m 2| grep ' : '
```
Should output ̀ SUCCESS` in all cases.
## Tests
The written tests aim to check corner cases, but are by no mean covering all of them.

## Automatic tests generators
Shift instructions can be (more or less) exhaustively tested regarding shift amount.
To that end, we wrote generators (quick and dirty hacks, tough useful) that produce test files.
We first wrote for the full register size and then the sub register sizes, which is ugly, merging all in one should be done.
Examples of use (`5` in the examples is the number of random number on which to apply all shifts, so don’t be too greedy), and w produces sxxw insns while d produces sxxd insns:

```
% ./generate_shifts_imm.py 5
% ./generate_shifts_reg.py 5
% ./prgchk.py unit_tests_i/test_shifts_imm.S
% ./prgchk.py unit_tests_i/test_shifts_reg.S
% ./generate_shifts_imm_wd.py w 5
% ./prgchk.py unit_tests_i/test_shifts_imm_w.S
% ./generate_shifts_imm_wd.py d 5
% ./prgchk.py unit_tests_i/test_shifts_imm_d.S
% ./generate_shifts_reg_wd.py w 5
% ./prgchk.py unit_tests_i/test_shifts_reg_w.S
% ./generate_shifts_reg_wd.py d 5
% ./prgchk.py unit_tests_i/test_shifts_reg_d.S
```

## Configuration & Usage
To use the automatic testing facilities, some system-specific values must be set in the `vars.py` file :
* `CROSS_GDB` : The path to a `gdb` executable that supports the RISC-V 64 target.
* `CROSS_GCC`, `CROSS_LD` : The path to a `gcc` and `ld` binary respectively for a 64 bits RISC-V target.
