# 🎯 Road to Data Analyst: SQL Portfolio & Learning Log

A focused PostgreSQL learning log and portfolio documenting practical query mastery—from foundational syntax to multi-table joins, subqueries, and grouping aggregations—practiced on [PostgreSQL Exercises (pgexercises.com)](https://pgexercises.com).

> 💡 **Looking for all SQL code examples?**  
> Browse the dedicated examples document: **[`SQL_EXAMPLES.md`](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md)**

---

## 📊 Completed Progress Tracker

| # | Topic Area | Total Completed | Status | Core Concepts Practiced | Examples File |
|:---:|:---|:---:|:---:|:---|:---:|
| **1** | **Simple SQL Queries** | 12 / 12 | ✅ Completed | `SELECT`, `WHERE`, `LIKE`, `IN`, `CASE WHEN`, `DISTINCT`, `ORDER BY`, `UNION`, `MAX()` | [View SQL](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql) |
| **2** | **Joins & Subqueries** | 8 / 8 | ✅ Completed | `INNER JOIN`, `LEFT OUTER JOIN`, Self `JOIN`, 3-Table Joins, Correlated Subqueries, Derived Tables | [View SQL](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql) |
| **3** | **Aggregation** | 9 Completed | ✅ Completed | `COUNT(*)`, `SUM()`, `GROUP BY`, `HAVING`, `EXTRACT(month)`, `COUNT(DISTINCT)`, `LIMIT 1` | [View SQL](file:///c:/Users/Test/Desktop/sql/sql/aggregation.sql) |
| **4** | **Database Design & Data Loading** | In Progress | 🚀 Current Stage | Relational Schema DDL, Keys, Constraints, Ingesting Brazilian E-Commerce dataset | *Next* |

---

## 🗂️ Repository Structure

```text
├── README.md                   # High-level tracker and project overview
├── SQL_EXAMPLES.md             # All 29 query examples organized by topic
├── .gitignore                  # Git ignore rules
└── sql/                        # Raw SQL script files
    ├── simple_sql_queries.sql  # 12 basic SQL solutions
    ├── joins_and_subqueries.sql# 8 multi-table join and subquery solutions
    └── aggregation.sql         # 9 aggregation & GROUP BY solutions
```

---

## 🔗 Quick Links to Code & Examples

- 📖 **Full Catalog of Examples:** [SQL_EXAMPLES.md](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md)
  - [Simple Queries (12 Examples)](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md#1-simple-sql-queries)
  - [Joins and Subqueries (8 Examples)](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md#2-joins-and-subqueries)
  - [Aggregation (9 Examples)](file:///c:/Users/Test/Desktop/sql/SQL_EXAMPLES.md#3-aggregation)
- 💾 **Raw SQL Files:**
  - [sql/simple_sql_queries.sql](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql)
  - [sql/joins_and_subqueries.sql](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql)
  - [sql/aggregation.sql](file:///c:/Users/Test/Desktop/sql/sql/aggregation.sql)

---

## 🚀 Active Milestone: Database Design & Data Loading
- [ ] Create `olist_ecommerce` database in PostgreSQL (pgAdmin / VS Code).
- [ ] Write schema setup script with tables, data types, primary and foreign keys.
- [ ] Ingest Olist Brazilian E-Commerce dataset CSVs into PostgreSQL via `COPY` / `\copy`.
- [ ] Validate row counts and table relationships.
