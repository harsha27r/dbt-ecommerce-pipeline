# dbt E-Commerce Analytics Pipeline

End-to-end analytics pipeline built with dbt Core, DuckDB, and Python on the Olist Brazilian E-Commerce dataset (100k+ orders).

## What This Does

Transforms raw e-commerce data into clean, tested analytical models across three layers:

- **Staging** — standardizes raw CSV data (orders, customers, order items, payments)
- **Intermediate** — joins orders with payment data, calculates order-level metrics
- **Mart** — customer-level aggregations: lifetime value, avg order value, total items purchased

## Tech Stack

- **dbt Core 1.12** — model orchestration, testing, documentation
- **DuckDB** — local analytical database (no cloud required)
- **Python / pandas** — data preparation
- **Olist Dataset** — 100k+ real Brazilian e-commerce orders across 4 source tables

## Pipeline Structure
models/
├── staging/
│ ├── stg_orders.sql
│ ├── stg_customers.sql
│ ├── stg_order_items.sql
│ └── stg_payments.sql
├── intermediate/
│ └── int_orders_with_payments.sql
└── marts/
└── mart_customer_orders.sql


## Data Quality

8 automated tests covering uniqueness and null checks across all staging models — all passing.

## How to Run

```bash
pip install dbt-duckdb
dbt seed
dbt run
dbt test
```

## Key Metrics Produced

- Customer lifetime value (LTV)
- Average order value per customer
- Total items purchased per customer
- First and last order dates
- Delivery performance vs estimated dates