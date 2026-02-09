import pandas as pd
import yaml
from pathlib import Path
from typing import Any

script_dir = Path(__file__).resolve().parent

dtype_map_dataset_22 = {
    "technology": "category",
    "dbm": "Int16",
    "rsrp": "Int16",
    "rsrq": "Int16",
    "rssi": "Int16",
    "asu": "Int16",
    "earfcn": "Int32",
    "pci": "Int16",
    "ta": "Int16",
    "ci": "Int32",
    "tac": "Int16",
    "bands": "category",
    "modes": "category",
    "mcc": "UInt16",
    "mnc": "UInt16",
    "is_connected": "bool",
    "phone_abs_time": "int64",
    "rel_time": "float64",
    "companion_abs_time": "float64",
    "longitude": "float64",
    "latitude": "float64",
    "altitude": "float64",
    "companion_abs_time_readable": "object",
}

config: Any = None

with open(script_dir / "config.yaml", "r") as file:
    config = yaml.safe_load(file)

df = pd.read_csv(  # type: ignore
    config["dataset22"]["path"] + config["dataset22"]["logs"],
    dtype=dtype_map_dataset_22,  # type: ignore
    na_values=["Unavailable"],
    parse_dates=["companion_abs_time_readable"],
    engine="pyarrow",
)

print(df.info())
