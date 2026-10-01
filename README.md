# Cryptocurrency Market Data: Merging & Cleaning Pipeline

A data preparation project that consolidates and cleans historical daily market data for 23 major cryptocurrencies into a standardized, analysis-ready dataset.

---

## Project Overview

Raw cryptocurrency price datasets are often distributed across individual CSV files per coin. This project implements a straightforward Python/pandas pipeline that:
1. Ingests and combines individual coin datasets into a single master file.
2. Applies data type standardizations, removes redundant identifiers, and creates data quality flags.
3. Outputs a clean master CSV suitable for relational database import (e.g., MySQL) and downstream exploratory data analysis (EDA), business intelligence, or financial modeling.

---

## Structure

```text
├── Datasets/
│   ├── row/                     # 23 raw CSV files (one per cryptocurrency)
│   ├── merged/
│   │   └── crypto_master.csv    # Consolidated master dataset (37,082 rows, 11 columns)
│   └── cleaned/
│       └── crypto_master_cleaned.csv  # Final cleaned dataset (37,082 rows, 12 columns)
├── Notebook/
│   ├── Merge.ipynb              # Notebook for ingesting & merging raw coin files
│   ├── cleaning.ipynb           # Notebook for cleaning, column transformations & flagging
│   └── Understanding.ipynb      # Notebook for initial data exploration & inspection
├── SQL Query/
│   ├── Import.sql               # MySQL database & table creation schema with LOAD DATA script
│   └── problem statement.sql    # Data quality queries & analytical problem statement outlines
├── src/
│   ├── __init__.py
│   └── config.py                # Base project configuration
├── Cryptocurrency Market Intelligence.pdf
├── .gitignore
└── README.md
```

---

## Workflow & Data Processing Steps

### 1. Merging (`Notebook/Merge.ipynb`)
- Reads 23 individual CSV files from `Datasets/row/`:
  - *Aave, BinanceCoin, Bitcoin, Cardano, ChainLink, Cosmos, CryptocomCoin, Dogecoin, EOS, Ethereum, Iota, Litecoin, Monero, NEM, Polkadot, Solana, Stellar, Tether, Tron, Uniswap, USDCoin, WrappedBitcoin, XRP*.
- Extracts coin names from file stems and adds a `Crypto` column to each record.
- Concatenates records into a single DataFrame (37,082 rows).
- Parses the `Date` column into datetime format (`mixed` format).
- Sorts records chronologically by `Crypto` and `Date`.
- Exports the result to `Datasets/merged/crypto_master.csv`.

### 2. Cleaning & Transformation (`Notebook/cleaning.ipynb`)
- **Datetime Conversion**: Confirms `Date` is parsed as datetime objects.
- **Handling Zero Volume / Market Cap**: Instead of dropping rows with `0` values (which would cause data loss in early historical records), created explicit boolean flag columns:
  - `is_zero_volume` (`Volume == 0`)
  - `is_zero_marketcap` (`Marketcap == 0`)
- **Column Pruning**: Dropped the redundant serial number column (`SNo`).
- **Export**: Saved the transformed dataset to `Datasets/cleaned/crypto_master_cleaned.csv`.

### 3. Database Schema & Downstream Setup (`SQL Query/`)
- `Import.sql` defines the `crypto_daily` table schema in MySQL with `(symbol, observed_at)` as the composite primary key and imports `crypto_master_cleaned.csv`.
- `problem statement.sql` sets up foundational queries for data quality checks and problem statements targeting risk, liquidity, and performance metrics.

---

## Dataset Schema (`crypto_master_cleaned.csv`)

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `Name` | `str` | Name of the cryptocurrency (e.g., Bitcoin, Ethereum) |
| `Symbol` | `str` | Ticker symbol (e.g., BTC, ETH) |
| `Date` | `datetime` | Observation timestamp (YYYY-MM-DD HH:MM:SS) |
| `High` | `float64` | Highest price recorded during the observation period |
| `Low` | `float64` | Lowest price recorded during the observation period |
| `Open` | `float64` | Opening price for the period |
| `Close` | `float64` | Closing price for the period |
| `Volume` | `float64` | Trading volume during the period |
| `Marketcap` | `float64` | Market capitalization |
| `Crypto` | `str` | Normalized cryptocurrency identifier |
| `is_zero_volume` | `bool` | `True` if recorded Volume was 0, else `False` |
| `is_zero_marketcap` | `bool` | `True` if recorded Marketcap was 0, else `False` |

---

## Getting Started

### Requirements
- Python 3.9+
- Jupyter Notebook / JupyterLab
- pandas
