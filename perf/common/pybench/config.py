from enum import Enum
from typing import List, Optional

bitcnts = (32, 64, 128)

class Metric(Enum):
    TASK_CLOCK = "task-clock"
    BRANCH_MISSES = "branch-misses"
    L1_DATA_MISSES = "L1-dcache-load-misses"
    LLC_MISSES = "LLC-load-misses"

def get_all_metrics() -> List[Metric]:
    return list(Metric)

def metric_from_name(name: str) -> Optional[Metric]:
    for m in Metric:
        if m.value == name:
            return m
    return None

_metric_display_titles = {
    Metric.TASK_CLOCK : "Time taken", 
    Metric.BRANCH_MISSES: "Branch misses", 
    Metric.L1_DATA_MISSES: "L1 data cache misses", 
    Metric.LLC_MISSES: "LLC misses"
}

def get_metric_display_name(met: Metric) -> str:
    if met in _metric_display_titles:
        return _metric_display_titles[met]
    return met