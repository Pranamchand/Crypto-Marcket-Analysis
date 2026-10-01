"""
Central configuration for the Cryptocurrency Analytics Project.
"""
from pathlib import Path

# ============================================================
# PROJECT DIRECTORIES
# ============================================================
ROOT_DIR = Path(__file__).resolve().parent.parent

DATA_DIR = ROOT_DIR / "Datasets"
RAW_DATA_DIR = DATA_DIR / "row"
MERGED_DATA_DIR = DATA_DIR / "merged"

NOTEBOOK_DIR = ROOT_DIR / "Notebook"
SRC_DIR = ROOT_DIR / "src"