# 🎯 Road to Data Analyst: SQL Learning Log

Documentation of completed PostgreSQL exercises from [pgexercises.com](https://pgexercises.com).

---

## 📌 Completed Section: Simple SQL Queries (12 / 12) ✅

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

---

## 💻 Query Solutions & Notes

All SQL queries for this section are maintained in [`sql/simple_sql_queries.sql`](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql):

### 1. Retrieve everything from a table
```sql
SELECT * 
FROM cd.facilities;
```

### 2. Retrieve specific columns from a table
```sql
SELECT name, membercost 
FROM cd.facilities;
```

### 3. Control which rows are retrieved
```sql
SELECT * 
FROM cd.facilities 
WHERE membercost > 0;
```

### 4. Control which rows are retrieved - part 2
```sql
SELECT facid, name, membercost, monthlymaintenance 
FROM cd.facilities 
WHERE membercost > 0 
  AND (membercost < monthlymaintenance / 50.0);
```

### 5. Basic string searches
```sql
SELECT * 
FROM cd.facilities 
WHERE name LIKE '%Tennis%';
```

### 6. Matching against multiple possible values
```sql
SELECT * 
FROM cd.facilities 
WHERE facid IN (1, 5);
```

### 7. Classify results into buckets
```sql
SELECT name, 
       CASE 
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost
FROM cd.facilities;
```

### 8. Working with dates
```sql
SELECT memid, surname, firstname, joindate 
FROM cd.members 
WHERE joindate >= '2012-09-01';
```

### 9. Removing duplicates, and ordering results
```sql
SELECT DISTINCT surname 
FROM cd.members 
ORDER BY surname 
LIMIT 10;
```

### 10. Combining results from multiple queries
```sql
SELECT surname 
FROM cd.members 
UNION 
SELECT name 
FROM cd.facilities;
```

### 11. Simple aggregation
```sql
SELECT MAX(joindate) AS latest 
FROM cd.members;
```

### 12. More aggregation
```sql
SELECT firstname, surname, joindate 
FROM cd.members 
WHERE joindate = (
    SELECT MAX(joindate) 
    FROM cd.members
);
```
