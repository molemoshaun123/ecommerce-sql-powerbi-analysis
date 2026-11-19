# 🎯 Road to Data Analyst: SQL Learning Log

Documentation of completed PostgreSQL exercises from [pgexercises.com](https://pgexercises.com).

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

## 📌 2. Joins and Subqueries (3 Completed) 🔄

| # | Exercise | Core Concept | Status |
|:---:|:---|:---|:---:|
| 1 | **Retrieve the start times of members' bookings** | Multi-table `INNER JOIN` with table aliases and composite `WHERE` | ✅ Completed |
| 2 | **Work out the start times of bookings for tennis courts** | `INNER JOIN` with date-range boundary filtering and `ORDER BY` | ✅ Completed |
| 3 | **Produce a list of all members who have recommended another member** | Self `JOIN` on hierarchical relation with `DISTINCT` deduplication | ✅ Completed |
| 4 | Produce a list of all members, along with their recommender | Outer joins (`LEFT JOIN`) | ⚪ Pending |
| 5 | Produce a list of all members who have used a tennis court | Multi-table join across 3 tables | ⚪ Pending |
| 6 | Produce a list of costly bookings | Calculated expressions across joins | ⚪ Pending |
| 7 | Produce a list of all members, along with their recommender, using no joins | Correlated subqueries in `SELECT` list | ⚪ Pending |
| 8 | Produce a list of costly bookings, using a subquery | CTE / Subquery in `FROM` clause | ⚪ Pending |

📄 *All SQL queries for this section:* [`sql/joins_and_subqueries.sql`](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql)

---

## 💻 Query Solutions & Notes: Joins and Subqueries

### 1. Retrieve the start times of members' bookings
```sql
SELECT bks.starttime
FROM cd.bookings bks
INNER JOIN cd.members mems
    ON mems.memid = bks.memid
WHERE mems.firstname = 'David'
  AND mems.surname = 'Farrell';
```

### 2. Work out the start times of bookings for tennis courts
```sql
SELECT bks.starttime AS start, 
       facs.name AS name
FROM cd.bookings bks
INNER JOIN cd.facilities facs
    ON facs.facid = bks.facid
WHERE facs.name LIKE 'Tennis Court%'
  AND bks.starttime >= '2012-09-21'
  AND bks.starttime < '2012-09-22'
ORDER BY bks.starttime;
```

### 3. Produce a list of all members who have recommended another member
```sql
SELECT DISTINCT recs.firstname, 
       recs.surname
FROM cd.members mems
INNER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY surname, firstname;
```
