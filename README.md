# 🎯 Road to Data Analyst: SQL Learning Log

Documentation of completed PostgreSQL exercises from [pgexercises.com](https://pgexercises.com).

---

## 📌 Completed Exercises: Simple SQL Queries

Based on completed exercises in PostgreSQL Exercises:

| # | Exercise | Core Concept | Status |
|:---:|:---|:---|:---:|
| 1 | **Retrieve everything from a table** | `SELECT *` wildcard full-table scan | ✅ Completed |
| 2 | **Retrieve specific columns from a table** | Column selection / projection | ✅ Completed |
| 3 | **Control which rows are retrieved** | Row filtering with `WHERE` and comparison operators (`>`) | ✅ Completed |
| 4 | **Control which rows are retrieved - part 2** | Compound conditions (`AND`) and calculated field comparisons | ✅ Completed |
| 5 | **Basic string searches** | Pattern matching with `LIKE '%...%'` | ✅ Completed |
| 6 | **Matching against multiple possible values** | Set membership filtering using `IN (...)` | ✅ Completed |

---

## 💻 Query Solutions & Notes

All SQL queries for the completed tasks are documented in [`sql/simple_sql_queries.sql`](file:///c:/Users/Test/Desktop/sql/sql/simple_sql_queries.sql):

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
