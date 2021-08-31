#!/bin/env python3 
import json
import sys
from statistics import mean
from typing import Dict, List, Optional

import matplotlib.pyplot as plt
import numpy as np

from .common import MetricValue
from .config import Metric, bitcnts, get_metric_display_name, metric_from_name


def load_data(file: str) -> Dict[int, Dict[int, Dict[str, List[MetricValue]]]]:
    f = open(file)
    data = json.load(f)
    f.close()
    data_conv = {}

    for inval in data:
        data_conv[inval] = {}
        for bitsize in bitcnts:
            data_conv[inval][bitsize] = {}
            for metric in Metric:
                data_conv[inval][bitsize][metric.value] = []
                for mtval in data[inval][str(bitsize)][metric.value]:
                    data_conv[inval][bitsize][metric.value].append(MetricValue(**mtval))

    return data_conv


def plot_data(data_file: str, metric: Metric, prop: bool, plot_title: Optional[str] = None, x_label: Optional[str] = None) -> None:
    bench_data = load_data(data_file)

    x = list(bench_data.keys())
    y_means = [[] for _ in bitcnts]
    y_mean_delta = [np.zeros((2, len(x)), dtype=float) for _ in bitcnts]

    for i, bc in enumerate(bitcnts):
        for j, inval in enumerate(bench_data):
            values = [(v.prop if prop else v.raw_value) for v in bench_data[inval][bc][metric.value]]
            y_means[i].append(mean(values))
            y_mean_delta[i][0][j] = mean(values) - min(values)
            y_mean_delta[i][1][j] = max(values) - mean(values)

    plt.figure()
    for i, bs in enumerate(bitcnts):
        plt.errorbar(x, y_means[i], yerr=y_mean_delta[i], capsize=5, label=f"{bs} bits")
    plt.title(metric.value if plot_title is None else plot_title)
    plt.xlabel("Input variable" if x_label is None else x_label)
    plt.ylabel(f"{get_metric_display_name(metric)}")
    plt.legend()
    plt.tight_layout()
    plt.show()

def plot_main(plot_title: Optional[str] = None, x_label: Optional[str] = None):
    if len(sys.argv) < 3:
        print(f"Usage {sys.argv[0]} <data_file> <metric> [raw/prop]")
        sys.exit(1)

    metric = metric_from_name(sys.argv[2].strip())
    prop = False if len(sys.argv) < 4 else sys.argv[3].strip() == "prop"

    plot_data(sys.argv[1], metric, prop, plot_title, x_label)
