#!/bin/env python3

import dataclasses
import sys
import os
import csv
import json

from typing import Dict, List, Any

from .common import MetricValue
from .config import Metric, bitcnts, get_all_metrics

class PerfDialect(csv.Dialect):
    def __init__(self) -> None:
        self.delimiter = ";"
        self.doublequote = False
        self.escapechar = None
        self.lineterminator = '\n'
        self.quotechar = '"'
        self.quoting = csv.QUOTE_NONE
        self.skipinitialspace = True
        super().__init__()

def metrics_from_file(filename: str) -> Dict[str, MetricValue]:
    """
        Reads CSV file produced by perf stat -x ';', and extract metric values from it,
        returning them in a Dict with their name as key.
    """
    csv_file = None
    try:
        csv_file = open(filename, "r")
    except IOError:
        print(f"Couldn't open file '{filename}' for reading !", file=sys.stderr)
        sys.exit(1)
    
    metrics = {}
    reader = csv.reader(csv_file, PerfDialect())
    for row in reader:
        if (len(row) <= 1):
            continue
        
        name = row[2]
        rawval = None
        propval = None
        unit = row[1]

        try:
            rawval = float(row[0])
        except ValueError:
            pass

        try:
            propval = float(row[5])
        except ValueError:
            pass

        metrics[name] = MetricValue(rawval, propval, unit)

    csv_file.close()
    return metrics

def run_bench(test_variable: str, xvals: List[int], reps: int) -> Dict[int, Dict[int, Dict[str, float]]]:
    results = {}
    for x in xvals:
        results[x] = {}
        for bc in bitcnts:
            results[x][bc] = {}
            for met in get_all_metrics():
                results[x][bc][met.value] = []

            for _ in range(reps):
                os.system(f"make runm{bc} {test_variable}={x}")

                m = metrics_from_file("perf.csv")
                for met in get_all_metrics():
                    results[x][bc][met.value].append(dataclasses.asdict(m[met.value]))
    return results

def run_and_dump(test_variable: str, xvals: List[int], reps: int) -> None:
    res = run_bench(test_variable, xvals, reps)
    
    out = open("bench_res.json", "w")
    json.dump(res, out)
    out.close()