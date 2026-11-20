# 🎯 Road to Data Analyst: SQL Portfolio & Learning Log

A hands-on PostgreSQL repository documenting practical SQL proficiency—from foundational queries to multi-table joins, subqueries, and aggregations with `GROUP BY`—practiced on [PostgreSQL Exercises (pgexercises.com)](https://pgexercises.com) as preparation for real-world e-commerce analytics.

---

## 📊 Completed Milestones

| Topic Area | Total Exercises | Status | Core Skills Mastered |
|:---|:---:|:---:|:---|
| **1. Simple SQL Queries** | 12 / 12 | ✅ 100% Completed | `SELECT`, `WHERE`, `LIKE`, `IN`, `CASE WHEN`, `DISTINCT`, `ORDER BY`, `UNION`, `MAX()` |
| **2. Joins & Subqueries** | 8 / 8 | ✅ 100% Completed | `INNER JOIN`, `LEFT JOIN`, Self `JOIN`, 3-Table Joins, Correlated Subqueries, Derived Tables |
| **3. Aggregation** | 4 Completed | 🔄 In Progress | `COUNT(*)`, `SUM()`, `WHERE` with Aggregates, `GROUP BY`, `ORDER BY` |
| **4. Database Design & Loading** | — | ⚪ Next Milestone | PostgreSQL Schema, DDL constraints, Kaggle Olist Dataset ingestion |

---

## 📌 Completed Section Details

### 1. Simple SQL Queries (12 / 12) ✅
*Source file:* [`sql/simple_sql_queries.sql`](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql)
- Full table scans (`SELECT *`) & projection
- Predicate filtering (`WHERE`, compound `AND`, numeric logic)
- Pattern matching (`LIKE '%Tennis%'`) & set inclusions (`IN (1, 5)`)
- Conditional buckets (`CASE WHEN`)
- Date filtering (`joindate >= '2012-09-01'`)
- Deduplication and slicing (`DISTINCT`, `ORDER BY`, `LIMIT`)
- Set combination (`UNION`) and scalar aggregate subqueries

### 2. Joins & Subqueries (8 / 8) ✅
*Source file:* [`sql/joins_and_subqueries.sql`](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql)
- Multi-table `INNER JOIN` across bookings, members, and facilities
- Date range boundary matching on joined records
- Self `JOIN` on hierarchical referral chains
- `LEFT OUTER JOIN` handling `NULL` values for unmatched rows
- Complex multi-table joins with conditional pricing logic (`CASE WHEN`)
- Scalar correlated subqueries in `SELECT`
- Inline derived tables / subqueries in `FROM` clause to avoid code duplication

### 3. Aggregation (4 Completed) 🔄
*Source file:* [`sql/aggregation.sql`](file:///c:/Users/Test/Desktop/sql/sql/aggregation.sql)

| # | Exercise | User's Core Query | Core Concept | Status |
|:---:|:---|:---|:---|:---:|
| 1 | **Count the number of facilities** | `SELECT count(*) AS Total_facilities FROM cd.facilities;` | Basic `COUNT(*)` aggregation | ✅ Completed |
| 2 | **Count the number of expensive facilities** | `SELECT count(*) AS number_facilities FROM cd.facilities WHERE guestcost >= 10;` | Filtered aggregate with `WHERE` | ✅ Completed |
| 3 | **Count the number of recommendations each member makes** | `SELECT recommendedby, count(*) FROM cd.members WHERE recommendedby IS NOT NULL GROUP BY recommendedby ORDER BY recommendedby;` | Grouped aggregation (`GROUP BY`) | ✅ Completed |
| 4 | **List the total slots booked per facility** | `SELECT facid, SUM(slots) AS Total_slots FROM cd.bookings GROUP BY facid ORDER BY facid;` | `SUM()` aggregate over groups | ✅ Completed |

---

## 💡 Practical SQL Highlights & Code Examples

### 1. Counting with Constraints
```sql
-- Count facilities with guestcost of 10 or more
SELECT count(*) AS number_facilities
FROM cd.facilities
WHERE guestcost >= 10;
```

---

### 2. Grouped Aggregation (`GROUP BY`)
```sql
-- Count recommendations made by each member, excluding nulls
SELECT recommendedby,
       count(*)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;
```

---

### 3. Summing Quantities Across Groups
```sql
-- Total slots booked per facility, sorted by facility id
SELECT facid,
       SUM(slots) AS Total_slots
FROM cd.bookings
GROUP BY facid
ORDER BY facid;
```

---

### 4. Multi-Table `INNER JOIN`
```sql
-- Find start times for all bookings made by 'David Farrell'
SELECT bks.starttime
FROM cd.bookings bks
INNER JOIN cd.members mems
    ON mems.memid = bks.memid
WHERE mems.firstname = 'David'
  AND mems.surname = 'Farrell';
```

---

### 5. Self `JOIN` (Hierarchical Relationships)
```sql
-- Output distinct members who have recommended another member
SELECT DISTINCT recs.firstname, 
       recs.surname
FROM cd.members mems
INNER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY surname, firstname;
```

---

### 6. `LEFT OUTER JOIN` (Preserving Unmatched Records)
```sql
-- List all members along with their recommender (including members with no recommender)
SELECT mems.firstname AS member_firstname, 
       mems.surname   AS member_surname, 
       recs.firstname AS recommender_firstname, 
       recs.surname   AS recommender_surname
FROM cd.members mems
LEFT OUTER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY member_surname, member_firstname;
```

---

### 7. Derived Tables & Subqueries
```sql
-- Filter bookings exceeding $30 without repeating the cost formula
SELECT member, facility, cost
FROM (
    SELECT mems.firstname || ' ' || mems.surname AS member,
           facs.name AS facility,
           CASE 
               WHEN mems.memid = 0 THEN bks.slots * facs.guestcost
               ELSE bks.slots * facs.membercost
           END AS cost
    FROM cd.members mems
    INNER JOIN cd.bookings bks
        ON mems.memid = bks.memid
    INNER JOIN cd.facilities facs
        ON bks.facid = facs.facid
    WHERE bks.starttime >= '2012-09-14'
      AND bks.starttime < '2012-09-15'
) AS subquery
WHERE cost > 30
ORDER BY cost DESC;
```

---

## 📁 Source Code Files

- 📄 [`sql/simple_sql_queries.sql`](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql) — 12 foundational SQL solutions.
- 📄 [`sql/joins_and_subqueries.sql`](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql) — 8 multi-table join and subquery solutions.
- 📄 [`sql/aggregation.sql`](file:///c:/Users/Test/Desktop/sql/sql/aggregation.sql) — Solutions for Aggregates & Grouping.

---

## 📌 Next Milestone
- [ ] Complete remaining exercises in **Aggregation** on pgexercises.com.
- [ ] Transition to **Database Design & Data Loading** (PostgreSQL schema setup & loading Kaggle Olist E-Commerce dataset).
