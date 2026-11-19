-- ==============================================================================
-- Day 1: SQL Syntax Refresh & Foundation Exercises
-- Source: PostgreSQL Exercises (pgexercises.com)
-- Focus: Joins, Filtering, Aggregations & Subqueries
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- SECTION 1: SIMPLE SQL QUERIES (COMPLETED)
-- ------------------------------------------------------------------------------

-- Exercise 1: Retrieve everything from a table
-- Problem: How can you retrieve all the information from the cd.facilities table?
SELECT * 
FROM cd.facilities;

-- Exercise 2: Retrieve specific columns from a table
-- Problem: Print out a list of all of the facilities and their cost to members.
SELECT name, membercost 
FROM cd.facilities;

-- Exercise 3: Control which rows are retrieved (Basic WHERE filtering)
-- Problem: Produce a list of facilities that charge a fee to members.
SELECT * 
FROM cd.facilities 
WHERE membercost > 0;

-- Exercise 4: Control which rows are retrieved - part 2 (Compound WHERE conditions)
-- Problem: Produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost.
SELECT facid, name, membercost, monthlymaintenance 
FROM cd.facilities 
WHERE membercost > 0 
  AND (membercost < monthlymaintenance / 50.0);

-- Exercise 5: Basic string searches (Pattern Matching with LIKE)
-- Problem: Produce a list of all facilities with the word 'Tennis' in their name.
SELECT * 
FROM cd.facilities 
WHERE name LIKE '%Tennis%';

-- Exercise 6: Matching against multiple possible values (IN operator)
-- Problem: Retrieve the details of facilities with ID 1 and 5.
SELECT * 
FROM cd.facilities 
WHERE facid IN (1, 5);

-- ------------------------------------------------------------------------------
-- SECTION 2: EXTENDED PRACTICE (CASE STATEMENTS, DATES & SORTING)
-- ------------------------------------------------------------------------------

-- Exercise 7: Classify results into buckets (CASE WHEN conditional logic)
-- Problem: Label facilities as 'cheap' or 'expensive' depending on if monthlymaintenance > 100.
SELECT name,
       CASE 
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost_category
FROM cd.facilities;

-- Exercise 8: Working with dates
-- Problem: Produce a list of members who joined after the start of September 2012.
SELECT memid, surname, firstname, joindate 
FROM cd.members 
WHERE joindate >= '2012-09-01';

-- Exercise 9: Removing duplicates and ordering results
-- Problem: Produce an ordered list of the first 10 surnames in the members table, removing duplicates.
SELECT DISTINCT surname 
FROM cd.members 
ORDER BY surname 
LIMIT 10;

-- ------------------------------------------------------------------------------
-- SECTION 3: MULTI-TABLE JOINS (INNER, LEFT, SELF JOINS)
-- ------------------------------------------------------------------------------

-- Exercise 10: Inner Join
-- Problem: Retrieve start times of bookings for tennis court facilities on 2012-09-21.
SELECT bks.starttime, facs.name
FROM cd.facilities facs
INNER JOIN cd.bookings bks
    ON facs.facid = bks.facid
WHERE facs.name LIKE 'Tennis Court%'
  AND bks.starttime >= '2012-09-21'
  AND bks.starttime < '2012-09-22'
ORDER BY bks.starttime;

-- Exercise 11: Self Join (Hierarchical / Parent-Child data)
-- Problem: Find who recommended each member (self-joining cd.members).
SELECT m.firstname AS mem_fname, 
       m.surname   AS mem_sname, 
       r.firstname AS rec_fname, 
       r.surname   AS rec_sname
FROM cd.members m
LEFT OUTER JOIN cd.members r
    ON r.memid = m.recommendedby
ORDER BY mem_sname, mem_fname;

-- ------------------------------------------------------------------------------
-- SECTION 4: AGGREGATIONS & WINDOW FUNCTION PREVIEW
-- ------------------------------------------------------------------------------

-- Exercise 12: Aggregation with GROUP BY & HAVING
-- Problem: Produce a count of the number of recommendations each member has made.
SELECT recommendedby, COUNT(*) AS count
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY count DESC;

-- Exercise 13: Window Function Preview (ROW_NUMBER & RANK)
-- Problem: Rank facilities by membercost within each category
SELECT facid, name, membercost,
       ROW_NUMBER() OVER (ORDER BY membercost DESC) as cost_row_num,
       RANK() OVER (ORDER BY membercost DESC) as cost_rank
FROM cd.facilities;
