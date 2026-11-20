# 📊 End-to-End E-Commerce Sales & Customer Retention Analysis

An enterprise-grade, end-to-end data analytics portfolio project examining **~100,000 real-world customer orders** from the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle. 

This repository documents the entire analytics lifecycle: **SQL syntax foundations**, **relational database architecture (PostgreSQL 18)**, **business exploratory data analysis**, **statistical modeling in Python**, and **executive KPI dashboards in Power BI**.

> 💡 **Looking for all SQL practice queries from the syntax refresh?**  
> Browse the dedicated reference file: **[`SQL_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md)**

---

## 📈 Roadmap & Milestone Progress

| Stage | Focus Area | Status | Key Deliverables |
|:---:|:---|:---:|:---|
| **Day 1** | **SQL Syntax Refresh** | ✅ **Completed** | Mastered 29 queries across Simple Queries, Joins, and Aggregations on pgexercises.com |
| **Day 2** | **Database Design & Data Loading** | ✅ **Completed** | PostgreSQL 18 database setup, relational schema, `psql \copy` bulk ingestion, 311,532 rows verified |
| **Day 3** | **Exploratory SQL & Window Functions** | 🔄 **Next Stage** | Business queries with `LAG()`, `ROW_NUMBER()`, cohort retention, and revenue trends |
| **Day 4** | **Python (pandas) Data Cleaning & Stats** | ⚪ *Planned* | Jupyter notebook, hypothesis testing (`scipy.stats`), seaborn visualization exports |
| **Day 5** | **Power BI Data Modeling & DAX** | ⚪ *Planned* | Dimensional Star Schema modeling, core DAX business measures |
| **Day 6** | **Power BI Dashboard Design** | ⚪ *Planned* | Single-page Executive Sales & Logistics Dashboard |
| **Day 7** | **Executive Presentation & CV Polish** | ⚪ *Planned* | Commercial findings, actionable business storytelling, CV impact metrics |

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
    ├── simple_sql_queries.sql     # Day 1: 12 simple SQL queries
    ├── joins_and_subqueries.sql   # Day 1: 8 multi-table join queries
    └── aggregation.sql            # Day 1: 9 aggregation queries
```

---

## 🚀 Upcoming Milestone: Day 3 — Exploratory SQL & Window Functions
- Month-over-month revenue trends and growth rate using `LAG()`.
- Customer repeat-purchase rates and cohort retention.
- Average delivery lead times vs estimated delivery times (late delivery rate).
- Top product categories by revenue and gross margin.
