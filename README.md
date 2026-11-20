# 🎯 Road to Data Analyst: SQL Portfolio & Learning Log

A hands-on PostgreSQL repository documenting practical SQL proficiency—from foundational queries to multi-table joins, conditional logic, and subqueries—practiced on [PostgreSQL Exercises (pgexercises.com)](https://pgexercises.com) as preparation for real-world e-commerce analytics.

---

## 📊 Completed Milestones

| Topic Area | Total Exercises | Status | Core Skills Mastered |
|:---|:---:|:---:|:---|
| **1. Simple SQL Queries** | 12 / 12 | ✅ 100% Completed | `SELECT`, `WHERE`, `LIKE`, `IN`, `CASE WHEN`, `DISTINCT`, `ORDER BY`, `UNION`, `MAX()` |
| **2. Joins & Subqueries** | 8 / 8 | ✅ 100% Completed | `INNER JOIN`, `LEFT JOIN`, Self `JOIN`, 3-Table Joins, Correlated Subqueries, Derived Tables |
| **3. Aggregates & Grouping** | — | 🔄 Up Next | `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`, Window Functions |
| **4. Database Design & Loading** | — | ⚪ Upcoming | PostgreSQL Schema, DDL constraints, Kaggle Olist Dataset ingestion |

---

## 💡 Practical SQL Examples & Code Snippets

Here are key examples showcasing the core techniques practiced and mastered:

### 1. Basic Filtering & Compound Conditions
Filtering data with numeric logic and multiple constraints:
```sql
-- Retrieve facilities that charge a fee less than 1/50th of monthly maintenance
SELECT facid, name, membercost, monthlymaintenance 
FROM cd.facilities 
WHERE membercost > 0 
  AND (membercost < monthlymaintenance / 50.0);
```

---

### 2. Segmenting Data with `CASE WHEN`
Creating conditional label columns for business categorization:
```sql
-- Classify facilities into 'cheap' vs 'expensive' cost buckets
SELECT name, 
       CASE 
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost_category
FROM cd.facilities;
```

---

### 3. Date Filtering, Deduplication & Ranking
Working with timestamp data, sorting, and slicing top records:
```sql
-- Get top 10 unique member surnames in alphabetical order
SELECT DISTINCT surname 
FROM cd.members 
ORDER BY surname 
LIMIT 10;
```

---

### 4. Multi-Table `INNER JOIN`
Combining related entities (members and bookings) to answer specific questions:
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

### 5. Self `JOIN` (Parent-Child / Hierarchical Data)
Joining a table to itself to resolve relationship hierarchies:
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
Ensuring all primary records appear even if matching foreign records do not exist (`NULL` handling):
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
Wrapping complex calculations into an inline subquery in the `FROM` clause to avoid duplicating logic:
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

- 📄 [`sql/simple_sql_queries.sql`](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql) — Complete set of 12 basic SQL solutions.
- 📄 [`sql/joins_and_subqueries.sql`](file:///c:/Users/Test/Desktop/sql/sql/joins_and_subqueries.sql) — Complete set of 8 multi-table join and subquery solutions.

---

## 📌 Next Milestone
- [ ] Practice **Aggregates** on pgexercises (`COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`).
- [ ] Move to **Database Design & Data Loading** (PostgreSQL schema creation and Olist E-Commerce dataset loading).
