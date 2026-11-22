# 📊 End-to-End E-Commerce Sales & Customer Retention Analysis

An enterprise-grade, end-to-end data analytics portfolio project examining **~100,000 real-world customer orders** from the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle. 

This repository documents the entire analytics lifecycle: **SQL syntax foundations**, **relational database architecture (PostgreSQL 18)**, **business exploratory data analysis**, **Python (pandas) ETL & data cleaning**, and **executive KPI dashboards in Power BI**.

> 💡 **Looking for all SQL practice queries from the Day 1 syntax refresh?**  
> Browse the dedicated reference file: **[`SQL_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md)**

> 🐍 **Looking for all Day 4 Python (pandas) scripts and terminal execution outputs?**  
> Browse the complete walkthrough: **[`PYTHON_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/PYTHON_EXAMPLES.md)**

---

## 📈 Roadmap & Milestone Progress

| Stage | Focus Area | Status | Key Deliverables |
|:---:|:---|:---:|:---|
| **Day 1** | **SQL Syntax Refresh** | ✅ **Completed** | Mastered 29 queries across Simple Queries, Joins, and Aggregations on pgexercises.com |
| **Day 2** | **Database Design & Data Loading** | ✅ **Completed** | PostgreSQL 18 database setup, relational schema, `psql \copy` bulk ingestion, 311,532 rows verified |
| **Day 3** | **Exploratory SQL & Window Functions** | ✅ **Completed** | Business analysis queries (`LAG()`, CTEs, window functions) & Power BI views (`vw_monthly_sales`, `vw_state_performance`) |
| **Day 4** | **Python (pandas) Data Cleaning & Stats** | ✅ **Completed** | 4 modular Python scripts (step1–step4), datetime cleaning, multi-table pandas merges, and clean CSV exports (`clean_state_summary.csv`, `clean_top_products.csv`) — see [`PYTHON_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/PYTHON_EXAMPLES.md) |
| **Day 5** | **Power BI Data Modeling & DAX** | 🔄 **Next Stage** | Dimensional Star Schema modeling, core DAX business measures |
| **Day 6** | **Power BI Dashboard Design** | ⚪ *Planned* | Single-page Executive Sales & Logistics Dashboard |
| **Day 7** | **Executive Presentation & CV Polish** | ⚪ *Planned* | Commercial findings, actionable business storytelling, CV impact metrics |

---

## 🔍 Day 3: Key SQL Business Findings

All analytical queries and database view definitions are documented in [`sql/02_business_analysis.sql`](file:///c:/Users/Test/Desktop/sql/sql/02_business_analysis.sql).

### 1. Order Fulfillment Hygiene
- **97.02% of all orders (96,478 orders)** were successfully delivered to customers.
- **1.24% of orders (1,234 orders)** were either canceled (625) or unavailable (609), indicating a healthy operational fulfillment rate (>98% non-cancellation).
- Remaining orders were in transit (`shipped`: 1,107) or processing stages.

### 2. Peak Revenue Trends & MoM Growth
- Evaluated monthly realized sales across delivered orders using Common Table Expressions (CTEs) and the `LAG()` window function.
- **Record Month:** **November 2017 (Black Friday)** witnessed an explosive **+53.55% MoM revenue surge**, generating **R$ 1,153,364.20** across **7,289 delivered orders** (compared to R$ 751,139.69 in October 2017).
- Peak sustained order volumes continued throughout Q1–Q2 2018, stabilizing above R$ 950k per month.

### 3. Geographic Revenue Concentration (Pareto Distribution)
- Analyzed regional order volumes, revenue share, and Average Order Value (AOV) across all Brazilian states:
  - **São Paulo (SP):** The dominant powerhouse generating **37.42% of national revenue (R$ 5,768,713.58)** across 40,494 delivered orders (AOV: R$ 142.46).
  - **Rio de Janeiro (RJ):** Ranked #2 generating **13.33% of revenue (R$ 2,055,475.47)** across 12,350 orders (AOV: R$ 166.44).
  - **Minas Gerais (MG):** Ranked #3 generating **11.80% of revenue (R$ 1,818,084.61)** across 11,352 orders (AOV: R$ 160.16).
- **Core Insight:** The top 3 southeastern states account for **62.55% of total revenue**, highlighting a heavily concentrated regional customer base.

### 4. Delivery SLA & Late Delivery Rate Bottlenecks
- Benchmarked average delivery speed against estimated delivery promises for states with $\ge 500$ delivered orders:
  - **Highest Delay Rates (Northeastern Region):**
    - **Maranhão (MA):** **19.67% late delivery rate** with an average delivery duration of **21.6 days** (highest delay rate nationally).
    - **Ceará (CE):** **15.32% late delivery rate** (21.0 avg delivery days).
    - **Bahia (BA):** **14.04% late delivery rate** (19.4 avg delivery days).
  - **Critical Commercial Risk (RJ):** Despite being the #2 revenue generator, **Rio de Janeiro (RJ)** suffers a severe **13.47% late delivery rate (1,664 late orders)** taking an average of **15.5 days**—contrasting sharply with neighboring **São Paulo (SP)**, which maintains a low **5.89% late delivery rate** and an average delivery speed of **8.8 days**.

### 5. Reusable Analytical Views for BI & Python
Engineered two production-ready PostgreSQL views to serve as direct feeds for downstream statistical modeling in Python and interactive dashboards in Power BI:
- **`vw_monthly_sales`**: Aggregates monthly orders, product revenue, freight revenue, total revenue, and calculated MoM growth %.
- **`vw_state_performance`**: Aggregates state-level delivered orders, unique customer count, total revenue, AOV, average actual delivery days, average estimated delivery days, late order count, and late delivery %.

---

## 🐍 Day 4: Key Python (pandas) EDA & Data Quality Findings

All Python scripts, transformed datasets, and terminal outputs are documented in [`python-eda/`](file:///c:/Users/Test/Desktop/sql/python-eda) and [`PYTHON_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/PYTHON_EXAMPLES.md).

### 1. Data Hygiene & Integrity Audit
- Ingested **99,441 raw order records** across 8 schema attributes.
- Confirmed **96,478 delivered orders**.
- **Anomaly Detection:** Flagged an edge-case data quality defect where exactly **8 delivered orders** have `null` timestamps for `order_delivered_customer_date` (leaving 96,470 valid delivery durations calculated).

### 2. Delivery Distribution & Carrier SLA Efficiency
- **Actual Transit Times:** Delivery duration averages **12.09 days** (median: 10.0 days, IQR: 6.0–15.0 days, max: 209 days).
- **SLA Buffer:** Orders arrived on average **11.88 days ahead of schedule** (`delay_vs_estimate = -11.88 days`), demonstrating that Olist carriers set conservative customer delivery windows to buffer against transit friction.

### 3. Regional Revenue vs. Transit Speed Correlation
- Joined orders, order items, and customer geolocation tables into a 110,197-row denormalized dataset.
- **Speed & Volume Leader:** **São Paulo (SP)** leads national revenue at **R$ 5,067,633.16** across 40,501 orders, benefiting from the fastest fulfillment network in Brazil (**8.3 days avg delivery**).
- **Logistics Lag:** In contrast, high-potential regions like **Bahia (BA)** average **18.8 days** for delivery, signaling regional courier bottlenecks.
- Exported clean regional aggregations to [`python-eda/clean_state_summary.csv`](file:///c:/Users/Test/Desktop/sql/python-eda/clean_state_summary.csv) for Power BI visualization.

### 4. Product Revenue Concentration & Pricing Mix
- Aggregated delivered order items by SKU to evaluate volume vs. margin dynamics:
  - **High-Ticket / Low-Volume:** Product `d6160fb7873f184099d9bc95e30376af` generated **R$ 45,949.35** across only **33 orders** with an average unit price of **R$ 1,392.40**.
  - **Low-Ticket / High-Volume:** Product `99a4788cb24856965c36a24e339b6058` generated **R$ 42,049.66** across **477 orders** with an average unit price of **R$ 88.15**.
- Exported the top 20 revenue-generating SKUs to [`python-eda/clean_top_products.csv`](file:///c:/Users/Test/Desktop/sql/python-eda/clean_top_products.csv).

---

## 🛠️ Day 2 Implementation Log: Database Design & Data Loading

### 1. Dataset Acquisition
- Downloaded and extracted the real-world Brazilian E-Commerce dataset from Kaggle into the project workspace:
  - `olist_customers_dataset.csv`
  - `olist_orders_dataset.csv`
  - `olist_order_items_dataset.csv`

### 2. Environment Configuration (PostgreSQL 18 & pgAdmin 4)
- Configured local PostgreSQL 18 instance on Windows with pgAdmin 4.
- Initialized dedicated analytical database: `olist_ecommerce`.

### 3. Relational Schema Architecture
Designed and implemented 3 normalized relational tables enforcing referential integrity with Primary Key and Foreign Key constraints:
- **`customers`**: Primary key `customer_id`, tracking unique customer identities, zip codes, cities, and states.
- **`orders`**: Primary key `order_id`, foreign key `customer_id` referencing `customers(customer_id)`, capturing lifecycle timestamps (purchase, approval, carrier delivery, customer delivery, estimated delivery).
- **`order_items`**: Composite primary key `(order_id, order_item_id)`, foreign key `order_id` referencing `orders(order_id)`, recording product IDs, seller IDs, shipping limits, item prices, and freight values.

*Schema definition script:* [`sql/01_schema_and_load.sql`](file:///c:/Users/Test/Desktop/sql/sql/01_schema_and_load.sql)

### 4. Technical Challenge & Solution: Resolving Windows File Permissions
- **Issue**: Attempting server-side `COPY` within pgAdmin triggered Windows file permission errors:
  ```text
  ERROR: could not open file "..." for reading: Permission denied
  SQL state: 42501
  ```
- **Resolution**: Bypassed server filesystem restrictions by executing client-side bulk ingestion via `psql \copy` running under the authenticated user session with explicit UTF-8 encoding:
  ```sql
  \copy customers FROM 'data/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
  \copy orders FROM 'data/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
  \copy order_items FROM 'data/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
  ```

### 5. Data Ingestion & Row Count Verification
Executed automated verification query ensuring complete, lossless ingestion across all tables:
```sql
SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;
```

**Verified Record Counts:**
| Table Name | Ingested Row Count | Status |
|:---|:---:|:---:|
| `customers` | 99,441 | ✅ Fully Verified |
| `orders` | 99,441 | ✅ Fully Verified |
| `order_items` | 112,650 | ✅ Fully Verified |
| **Total Ingested** | **311,532 records** | ✅ 100% Match with Raw Data |

---

## 🗂️ Project Repository Structure

```text
ecommerce-sql-powerbi-analysis/
├── README.md                      # Comprehensive project documentation & daily log
├── SQL_EXAMPLES.md                # 29 foundational SQL practice queries (Day 1)
├── PYTHON_EXAMPLES.md             # Day 4 Python (pandas) walkthrough & outputs
├── .gitignore                     # Git rules (ignoring raw CSVs, archives, pycache)
├── python-eda/                    # Day 4 Python scripts and clean CSV outputs
│   ├── requirements.txt           # Python dependencies (pandas)
│   ├── step1_load.py              # Ingestion & schema inspection
│   ├── step2_clean_dates.py       # Datetime conversion & SLA audit
│   ├── step3_merge_groupby.py     # Multi-table merge & state aggregation
│   ├── step4_top_products.py      # Product revenue mix analysis
│   ├── clean_state_summary.csv    # Clean regional dataset for Power BI
│   └── clean_top_products.csv     # Clean top products dataset for Power BI
└── sql/                           # Day 1–3 PostgreSQL scripts
    ├── 01_schema_and_load.sql     # Day 2: DDL schema, \copy ingestion & row verification
    ├── 02_business_analysis.sql   # Day 3: EDA queries, window functions & Power BI views
    ├── simple_sql_queries.sql     # Day 1: 12 simple SQL queries
    ├── joins_and_subqueries.sql   # Day 1: 8 multi-table join queries
    └── aggregation.sql            # Day 1: 9 aggregation queries
```

---

## 🚀 Upcoming Milestone: Day 5 — Power BI Data Modeling & DAX
- Ingest `clean_state_summary.csv` and `clean_top_products.csv` (or connect to PostgreSQL views).
- Build Star Schema relationships between Fact and Dimension entities.
- Write core DAX measures (`Total Revenue`, `Total Orders`, `Average Order Value`, `Late Delivery %`).
