# 📊 End-to-End E-Commerce Sales & Customer Retention Analysis

An enterprise-grade, end-to-end data analytics portfolio project examining **~100,000 real-world customer orders** from the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle. 

This repository documents the entire analytics lifecycle: **SQL syntax foundations**, **relational database architecture (PostgreSQL 18)**, **business exploratory data analysis**, **statistical modeling in Python**, and **executive KPI dashboards in Power BI**.

> 💡 **Looking for all SQL practice queries from the Day 1 syntax refresh?**  
> Browse the dedicated reference file: **[`SQL_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md)**

---

## 📈 Roadmap & Milestone Progress

| Stage | Focus Area | Status | Key Deliverables |
|:---:|:---|:---:|:---|
| **Day 1** | **SQL Syntax Refresh** | ✅ **Completed** | Mastered 29 queries across Simple Queries, Joins, and Aggregations on pgexercises.com |
| **Day 2** | **Database Design & Data Loading** | ✅ **Completed** | PostgreSQL 18 database setup, relational schema, `psql \copy` bulk ingestion, 311,532 rows verified |
| **Day 3** | **Exploratory SQL & Window Functions** | ✅ **Completed** | Business analysis queries (`LAG()`, CTEs, window functions) & Power BI views (`vw_monthly_sales`, `vw_state_performance`) |
| **Day 4** | **Python (pandas) Data Cleaning & Stats** | 🔄 **Next Stage** | Jupyter notebook, hypothesis testing (`scipy.stats`), seaborn visualization exports |
| **Day 5** | **Power BI Data Modeling & DAX** | ⚪ *Planned* | Dimensional Star Schema modeling, core DAX business measures |
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
  In PostgreSQL on Windows, the background server process (`NETWORK SERVICE` / `postgres`) lacks read permissions to user Desktop/workspace directories.
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
├── .gitignore                     # Git rules (ignoring large CSVs, archives, pycache)
└── sql/
    ├── 01_schema_and_load.sql     # Day 2: DDL schema, \copy ingestion & row verification
    ├── 02_business_analysis.sql   # Day 3: EDA queries, window functions & Power BI views
    ├── simple_sql_queries.sql     # Day 1: 12 simple SQL queries
    ├── joins_and_subqueries.sql   # Day 1: 8 multi-table join queries
    └── aggregation.sql            # Day 1: 9 aggregation queries
```

---

## 🚀 Upcoming Milestone: Day 4 — Python (pandas) Data Cleaning & Stats
- Connect Python directly to PostgreSQL using `psycopg2` / `sqlalchemy` and `pandas.read_sql()`.
- Validate data types, evaluate missing records, and generate descriptive statistical summaries.
- Run statistical hypothesis testing using `scipy.stats` (testing whether delivery delays statistically lower customer review ratings).
- Export 2–3 publication-ready Seaborn/Matplotlib visualization charts.
