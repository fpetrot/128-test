from dataclasses import dataclass

@dataclass
class MetricValue:
    raw_value: float
    prop: float
    unit: str = ""