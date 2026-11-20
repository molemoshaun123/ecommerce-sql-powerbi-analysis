# 📚 All SQL Practice Examples & Solutions

This document compiles all SQL practice examples completed on [PostgreSQL Exercises (pgexercises.com)](https://pgexercises.com).

---

## 📑 Table of Contents
1. [Simple SQL Queries (12 Examples)](#1-simple-sql-queries)
2. [Joins and Subqueries (8 Examples)](#2-joins-and-subqueries)
3. [Aggregation (9 Examples)](#3-aggregation)

---

## 1. Simple SQL Queries

### Example 1: Retrieve everything from a table
```sql
SELECT * 
FROM cd.facilities;
```

### Example 2: Retrieve specific columns from a table
```sql
SELECT name, membercost 
FROM cd.facilities;
```

### Example 3: Control which rows are retrieved (Basic Filtering)
```sql
SELECT * 
FROM cd.facilities 
WHERE membercost > 0;
```

### Example 4: Compound conditions and arithmetic
```sql
SELECT facid, name, membercost, monthlymaintenance 
FROM cd.facilities 
WHERE membercost > 0 
  AND (membercost < monthlymaintenance / 50.0);
```

### Example 5: Basic string searches (Pattern Matching)
```sql
SELECT * 
FROM cd.facilities 
WHERE name LIKE '%Tennis%';
```

### Example 6: Matching against multiple possible values
```sql
SELECT * 
FROM cd.facilities 
WHERE facid IN (1, 5);
```

### Example 7: Classify results into buckets (`CASE WHEN`)
```sql
SELECT name, 
       CASE 
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost
FROM cd.facilities;
```

### Example 8: Working with dates
```sql
SELECT memid, surname, firstname, joindate 
FROM cd.members 
WHERE joindate >= '2012-09-01';
```

### Example 9: Removing duplicates, and ordering results
```sql
SELECT DISTINCT surname 
FROM cd.members 
ORDER BY surname 
LIMIT 10;
```

### Example 10: Combining results from multiple queries (`UNION`)
```sql
SELECT surname 
FROM cd.members 
UNION 
SELECT name 
FROM cd.facilities;
```

### Example 11: Simple aggregation (`MAX`)
```sql
SELECT MAX(joindate) AS latest 
FROM cd.members;
```

### Example 12: More aggregation (Subquery with aggregate)
```sql
SELECT firstname, surname, joindate 
FROM cd.members 
WHERE joindate = (
    SELECT MAX(joindate) 
    FROM cd.members
);
```

---

## 2. Joins and Subqueries

### Example 13: Multi-table `INNER JOIN`
```sql
SELECT bks.starttime
FROM cd.bookings bks
INNER JOIN cd.members mems
    ON mems.memid = bks.memid
WHERE mems.firstname = 'David'
  AND mems.surname = 'Farrell';
```

### Example 14: Join with date range filtering and sorting
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

### Example 15: Self `JOIN` on hierarchical data with `DISTINCT`
```sql
SELECT DISTINCT recs.firstname, 
       recs.surname
FROM cd.members mems
INNER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY surname, firstname;
```

### Example 16: `LEFT OUTER JOIN` (Handling missing relationships / `NULL`s)
```sql
SELECT mems.firstname AS memfname, 
       mems.surname   AS memsname, 
       recs.firstname AS recfname, 
       recs.surname   AS recsname
FROM cd.members mems
LEFT OUTER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY memsname, memfname;
```

### Example 17: Three-table `INNER JOIN` with string concatenation
```sql
SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member, 
       facs.name AS facility
FROM cd.members mems
INNER JOIN cd.bookings bks
    ON mems.memid = bks.memid
INNER JOIN cd.facilities facs
    ON bks.facid = facs.facid
WHERE facs.name LIKE 'Tennis Court%'
ORDER BY member, facility;
```

### Example 18: Multi-table join with conditional pricing logic (`CASE WHEN`)
```sql
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
  AND (
      (mems.memid = 0 AND bks.slots * facs.guestcost > 30) OR
      (mems.memid != 0 AND bks.slots * facs.membercost > 30)
  )
ORDER BY cost DESC;
```

### Example 19: Scalar correlated subquery in `SELECT` list
```sql
SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member,
       (SELECT recs.firstname || ' ' || recs.surname 
        FROM cd.members recs 
        WHERE recs.memid = mems.recommendedby) AS recommender
FROM cd.members mems
ORDER BY member;
```

### Example 20: Derived table / Inline subquery in `FROM` clause
```sql
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

## 3. Aggregation

### Example 21: Count the number of facilities
```sql
SELECT count(*) AS Total_facilities
FROM cd.facilities;
```

### Example 22: Count the number of expensive facilities
```sql
SELECT count(*) AS number_facilities
FROM cd.facilities
WHERE guestcost >= 10;
```

### Example 23: Count recommendations per member (`GROUP BY`)
```sql
SELECT recommendedby,
       count(*)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;
```

### Example 24: List the total slots booked per facility (`SUM` + `GROUP BY`)
```sql
SELECT facid,
       SUM(slots) AS Total_slots
FROM cd.bookings
GROUP BY facid
ORDER BY facid;
```

### Example 25: Total slots booked per facility in a given month
```sql
SELECT facid, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-09-01'
  AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY SUM(slots);
```

### Example 26: Total slots booked per facility per month in 2012
```sql
SELECT facid, 
       EXTRACT(month FROM starttime) AS month, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-01-01'
  AND starttime < '2013-01-01'
GROUP BY facid, month
ORDER BY facid, month;
```

### Example 27: Count of unique members who made at least one booking
```sql
SELECT COUNT(DISTINCT memid) 
FROM cd.bookings;
```

### Example 28: Facilities with more than 1000 slots booked (`HAVING`)
```sql
SELECT facid, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;
```

### Example 29: Facility with the highest number of slots booked (Top-N)
```sql
SELECT facid, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
ORDER BY SUM(slots) DESC
LIMIT 1;
```
