# 🎯 Road to Data Analyst: SQL Learning Log

Documentation of completed PostgreSQL exercises from [pgexercises.com](https://pgexercises.com) preparing for the End-to-End E-Commerce Data Analytics Project.

---

## 📌 1. Simple SQL Queries (12 / 12) ✅

| # | Exercise | Core Concept | Status |
|:---:|:---|:---|:---:|
| 1 | **Retrieve everything from a table** | `SELECT *` wildcard full-table scan | ✅ Completed |
| 2 | **Retrieve specific columns from a table** | Column selection / projection | ✅ Completed |
| 3 | **Control which rows are retrieved** | Row filtering with `WHERE` and comparison operators (`>`) | ✅ Completed |
| 4 | **Control which rows are retrieved - part 2** | Compound conditions (`AND`) and calculated comparisons | ✅ Completed |
| 5 | **Basic string searches** | Pattern matching with `LIKE '%...%'` | ✅ Completed |
| 6 | **Matching against multiple possible values** | Set membership filtering using `IN (...)` | ✅ Completed |
| 7 | **Classify results into buckets** | Conditional logic with `CASE WHEN ... THEN ... ELSE ... END` | ✅ Completed |
| 8 | **Working with dates** | Date / Timestamp comparison filtering (`>= '2012-09-01'`) | ✅ Completed |
| 9 | **Removing duplicates, and ordering results** | Deduplication (`DISTINCT`), sorting (`ORDER BY`), and slicing (`LIMIT`) | ✅ Completed |
| 10 | **Combining results from multiple queries** | Result set combination with `UNION` | ✅ Completed |
| 11 | **Simple aggregation** | Aggregation using `MAX()` | ✅ Completed |
| 12 | **More aggregation** | Subqueries in filtering (`WHERE col = (SELECT MAX(...))`) | ✅ Completed |

📄 *All SQL queries for this section:* [`sql/simple_sql_queries.sql`](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql)

---

## 📌 2. Joins and Subqueries (8 / 8) ✅

| # | Exercise | Core Concept | Status |
|:---:|:---|:---|:---:|
| 1 | **Retrieve the start times of members' bookings** | Multi-table `INNER JOIN` with table aliases and composite `WHERE` | ✅ Completed |
| 2 | **Work out the start times of bookings for tennis courts** | `INNER JOIN` with date-range boundary filtering and `ORDER BY` | ✅ Completed |
| 3 | **Produce a list of all members who have recommended another member** | Self `JOIN` on hierarchical relation with `DISTINCT` deduplication | ✅ Completed |
| 4 | **Produce a list of all members, along with their recommender** | `LEFT OUTER JOIN` to preserve unmatched records and handle `NULL`s | ✅ Completed |
| 5 | **Produce a list of all members who have used a tennis court** | Multi-table join across 3 tables (`members` ⨝ `bookings` ⨝ `facilities`) | ✅ Completed |
| 6 | **Produce a list of costly bookings** | Multi-table join with dynamic calculations and conditional `CASE WHEN` | ✅ Completed |
| 7 | **Produce a list of all members, along with their recommender, using no joins** | Scalar correlated subquery in `SELECT` projection list | ✅ Completed |
| 8 | **Produce a list of costly bookings, using a subquery** | Derived table / Inline subquery in `FROM` clause to avoid DRY duplication | ✅ Completed |

📄 *All SQL queries for this section:* [`sql/joins_and_subqueries.sql`](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql)

---

## 🚀 Next Steps in Roadmap

1. **Aggregates Section** *(Up Next on pgexercises.com)*:
   - `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
   - `GROUP BY` and `HAVING` clauses
   - Nested aggregations & window function foundations
2. **Database Design & Data Loading**:
   - Create `olist_ecommerce` PostgreSQL database
   - Relational DDL schema setup with primary/foreign keys
   - Ingesting Olist Brazilian E-Commerce dataset CSVs via `\copy`
