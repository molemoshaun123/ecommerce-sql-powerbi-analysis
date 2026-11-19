# 7-Day Road to Data Analyst: Action Roadmap & Project Tracker

**Project:** End-to-End E-Commerce Sales & Customer Retention Analysis  
**Dataset:** Brazilian E-Commerce Public Dataset by Olist (~100k real orders)  
**Tech Stack:** PostgreSQL | Python (pandas, scipy, seaborn) | Power BI Desktop | Git & GitHub  

---

## Progress Overview

| Day | Focus Area | Status | Key Deliverable |
|:---:|:---|:---:|:---|
| **Day 1** | **SQL Syntax Refresh & Setup** | 🟡 **In Progress** | Setup local repo, pgexercises refresh, git init |
| **Day 2** | **Database Design & Data Loading** | ⚪ *Planned* | `01_schema_setup.sql`, PostgreSQL import of 8 CSVs |
| **Day 3** | **Exploratory SQL & Window Functions** | ⚪ *Planned* | `02_business_analysis.sql` with 6 business queries |
| **Day 4** | **Python (pandas) Data Cleaning & Stats** | ⚪ *Planned* | `03_statistical_eda.ipynb`, hypothesis test, seaborn charts |
| **Day 5** | **Power BI Data Modeling & DAX** | ⚪ *Planned* | Star schema model, core DAX calculated measures |
| **Day 6** | **Power BI Dashboard Design** | ⚪ *Planned* | Single-page Executive Sales & Logistics Dashboard |
| **Day 7** | **GitHub Documentation & CV Polish** | ⚪ *Planned* | Comprehensive README, executive summary, CV bullet points |

---

## Detailed Daily Breakdown & Checklist

### 🟡 Day 1: SQL Syntax Refresh & Setup
- [x] **PostgreSQL Exercises (pgexercises.com) - Simple Queries**
  - [x] Retrieve everything from a table (`SELECT *`)
  - [x] Retrieve specific columns from a table (`SELECT col1, col2`)
  - [x] Control which rows are retrieved (`WHERE condition`)
  - [x] Control which rows are retrieved - part 2 (`WHERE AND/OR numeric calculations`)
  - [x] Basic string searches (`LIKE '%keyword%'`)
  - [x] Matching against multiple possible values (`IN (...)`)
- [ ] **PostgreSQL Exercises - Joins & Aggregations**
  - [ ] Classify results into buckets (`CASE WHEN`)
  - [ ] Working with dates & timestamps
  - [ ] Removing duplicates and ordering results (`DISTINCT`, `ORDER BY`, `LIMIT`)
  - [ ] Multi-table joins (`INNER JOIN`, `LEFT JOIN`, `SELF JOIN`)
  - [ ] Simple & grouped aggregations (`COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`)
- [x] **Project Repository Initialization**
  - [x] Create project structure (`sql/`, `data/`, `notebooks/`, `powerbi/`, `images/`)
  - [x] Configure `.gitignore` for large CSV files and temporary cache
  - [x] Create remote repository on GitHub (`ecommerce-sql-powerbi-analysis`)
  - [x] Commit and push initial setup and Day 1 SQL refresh scripts
- [ ] **Data Acquisition**
  - [ ] Download Brazilian E-Commerce dataset from Kaggle into `/data` folder

---

### ⚪ Day 2: Database Design & Data Loading
- [ ] Open pgAdmin or VS Code (PostgreSQL extension) and create database `olist_ecommerce`.
- [ ] Run `01_schema_setup.sql` to generate relational schema:
  - `olist_customers`
  - `olist_orders`
  - `olist_order_items`
  - `olist_products`
  - `olist_order_payments`
  - `olist_order_reviews`
  - `olist_sellers`
  - `olist_geolocation`
- [ ] Execute `\copy` or `COPY` commands to ingest CSV files.
- [ ] Verify row counts and test foreign key constraints.

---

### ⚪ Day 3: Exploratory SQL & Window Functions
- [ ] Complete 3–4 PostgreSQL interview questions on DataLemur.
- [ ] Author `02_business_analysis.sql` addressing 6 real-world commercial questions:
  1. Monthly revenue trends and month-over-month growth rate using `LAG()`.
  2. Top 5 product categories by revenue and gross margin.
  3. Average delivery time vs estimated delivery time (late delivery rate calculation).
  4. Customer repeat-purchase rate and cohort retention analysis.
  5. Payment method breakdown and average installment counts.
  6. Seller fulfillment speed and correlation with review ratings.

---

### ⚪ Day 4: Python (pandas) Data Cleaning & Statistical EDA
- [ ] Create Jupyter Notebook `03_statistical_eda.ipynb`.
- [ ] Connect Python directly to PostgreSQL via `sqlalchemy` and `pandas.read_sql()`.
- [ ] Perform data validation, null treatment (`isnull()`, `fillna()`), and type coercion.
- [ ] Conduct statistical hypothesis testing using `scipy.stats` (e.g. Mann-Whitney U test on delivery delay impact on customer review score).
- [ ] Export 2–3 publication-ready Seaborn/Matplotlib plots into `/images`.

---

### ⚪ Day 5: Power BI Data Modeling & DAX
- [ ] Launch Power BI Desktop and connect to local PostgreSQL `olist_ecommerce` database.
- [ ] Transform and format tables in Power Query.
- [ ] Construct a dimensional Star Schema in Model View (linking fact orders/payments to dimension tables).
- [ ] Implement core DAX business measures:
  - `Total Revenue`
  - `Total Orders`
  - `Average Order Value (AOV)`
  - `Late Delivery %`
  - `Average Review Score`

---

### ⚪ Day 6: Power BI Dashboard Design
- [ ] Design high-impact, single-page Executive Sales & Logistics Dashboard:
  - 4 Executive KPI Cards across top header.
  - Monthly Revenue & Orders Trend (Dual-axis Line & Area Chart).
  - Category Revenue Contribution (Horizontal Bar Chart).
  - On-Time Delivery vs Customer Review Heatmap/Scatter.
  - Interactive slicers: Year/Quarter, Brazilian State, Payment Type.
- [ ] Export high-resolution dashboard screenshots to `/images/dashboard_overview.png`.

---

### ⚪ Day 7: GitHub Documentation & CV Polish
- [ ] Finalize repository `README.md` with executive findings and actionable commercial recommendations.
- [ ] Push all final code (`.sql`, `.ipynb`, `.pbix`, screenshots).
- [ ] Add project link and 3 concise, quantified bullet points to CV:
  - *Quantified revenue and delivery impact using PostgreSQL and Window Functions.*
  - *Statistical hypothesis testing validating correlation between delivery delays and customer ratings.*
  - *Engineered interactive Power BI executive dashboard tracking operational KPIs.*
