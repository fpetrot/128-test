#!/bin/env python3

from math import floor, ceil
import random
import sys

from random import randint
from typing import List, Tuple, Set

_OK_TYPESIZES = {32, 64, 128}
_DATA_DIRS = {32: ".word", 64: ".dword", 128: ".octa"}

_cnt = 1
def label_gen() -> str:
    global _cnt
    lbl = f"_label{hex(_cnt)}"
    _cnt += 1
    return lbl

def ptr_dir(label: str, typesize: int) -> str:
    if typesize == 128:
        return f".dword {label}, 0"
    else:
        return f"{_DATA_DIRS[typesize]} {label}"

class BST():
    def __init__(self, val: int, left: 'BST' = None, right: 'BST' = None) -> None:
        self.val = val
        self.left = left
        self.right = right

    def insert(self, new_val: int) -> bool:
        """Insert into BST, return True if value wasn't already in BST"""
        if new_val < self.val:
            if self.left is None:
                self.left = BST(new_val)
                return True
            else:
                return self.left.insert(new_val)
        elif new_val > self.val:
            if self.right is None:
                self.right = BST(new_val)
                return True
            else:
                return self.right.insert(new_val)
        else:
            return False

    def gen_asm(self, typesize: int, label_for_self: str) -> str:
        ts_dir = _DATA_DIRS[typesize]
        lbl_left = label_gen()
        lbl_right = label_gen()
        return f"""
{label_for_self}: {ts_dir} {hex(self.val)}
                  {ptr_dir(lbl_left if self.left else "0", typesize)}
                  {ptr_dir(lbl_right if self.right else "0", typesize)}
{self.left.gen_asm(typesize, lbl_left) if self.left else ""}
{self.right.gen_asm(typesize, lbl_right) if self.right else ""}
""".strip()
            

def gen_bst(typesize: int, size: int) -> Tuple[BST, Set[int]]:
    root = BST(randint(0, 2**typesize - 1))
    elems = set()
    num_insns = 1
    while num_insns != size:
        nv = randint(0, 2**typesize - 1)
        if root.insert(nv):
            elems.add(nv)
            num_insns += 1
    return (root, elems)
        

def gen_elems_to_search(num: int, elems_in_tree: Set[int], in_set_prop: float, typesize: int) -> List[int]:
    assert 0 <= in_set_prop <= 1
    to_search = list()

    elems_lst = list(elems_in_tree)
    to_search.extend(random.choice(elems_lst) for _ in range(floor(in_set_prop * num)))
    
    inserted = 0
    to_ins = ceil(num * (1 - in_set_prop))
    while inserted != to_ins:
        val = randint(0, 2**typesize - 1)
        if val not in elems_in_tree:
            to_search.append(val)
            inserted += 1
    return to_search

if __name__ == "__main__":
    # Usage <script> <typesize> <treesize> <searchcnt>
    if len(sys.argv) != 5:
        print(f"Usage {sys.argv[0]} <typesize> <treesize> <searchcnt> <repeats>")
        sys.exit(0)
    
    typesize = int(sys.argv[1])
    treesize = int(sys.argv[2])
    searchcnt = int(sys.argv[3])
    reps = int(sys.argv[4])

    assert typesize in _OK_TYPESIZES, "Invalid type size"
    assert treesize > 0, "Negative or nil tree size"
    assert searchcnt > 0, "Negative or nil search count"

    root, elems = gen_bst(typesize, treesize)

    to_search = gen_elems_to_search(searchcnt, elems, 0.5, typesize)

    with open("data.S", "w+") as data_file:
        data_file.write(".section .data\n")
        data_file.write(".global bst_root\n")
        data_file.write(root.gen_asm(typesize, "bst_root"))
        data_file.write("\n")

        data_file.write(".global search_size\n")
        data_file.write(f"search_size: {_DATA_DIRS[typesize]} {hex(len(to_search))}\n")
        data_file.write(".global search_tab\n")
        data_file.write(f"search_tab: {_DATA_DIRS[typesize]} ")
        for val in to_search:
            data_file.write(f" {hex(val)},")
        data_file.write("\n.global res_tab\n")
        data_file.write(f"res_tab: .byte ")
        for val in to_search:
            data_file.write(f"{1 if val in elems else 0},")

        data_file.write("\n")
        data_file.write(f".global repeat_cnt\nrepeat_cnt: {_DATA_DIRS[typesize]} {reps}\n")

