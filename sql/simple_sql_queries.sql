-- ==============================================================================
-- PostgreSQL Exercises (pgexercises.com)
-- Section: Simple SQL Queries
-- Status: 100% Completed (12 / 12 completed as per progress screenshot)
-- ==============================================================================

-- 1. Retrieve everything from a table
-- Question: How can you retrieve all the information from the cd.facilities table?
-- Concepts: SELECT statement, wildcard (*)
SELECT * 
FROM cd.facilities;


-- 2. Retrieve specific columns from a table
-- Question: You want to print out a list of all of the facilities and their cost 
--           to members. How would you retrieve a list of only facility names and costs?
-- Concepts: Column projection
SELECT name, membercost 
FROM cd.facilities;


-- 3. Control which rows are retrieved
-- Question: How can you produce a list of facilities that charge a fee to members?
-- Concepts: WHERE clause, numeric comparison operator (>)
SELECT * 
FROM cd.facilities 
WHERE membercost > 0;


-- 4. Control which rows are retrieved - part 2
-- Question: How can you produce a list of facilities that charge a fee to members, 
--           and that fee is less than 1/50th of the monthly maintenance cost? 
--           Return the facid, facility name, member cost, and monthly maintenance.
-- Concepts: Compound WHERE conditions (AND), arithmetic operations in SQL
SELECT facid, name, membercost, monthlymaintenance 
FROM cd.facilities 
WHERE membercost > 0 
  AND (membercost < monthlymaintenance / 50.0);


-- 5. Basic string searches
-- Question: How can you produce a list of all facilities with the word 'Tennis' in their name?
-- Concepts: Pattern matching, LIKE operator, wildcard character (%)
SELECT * 
FROM cd.facilities 
WHERE name LIKE '%Tennis%';


-- 6. Matching against multiple possible values
-- Question: How can you retrieve the details of facilities with ID 1 and 5? 
--           Try to do it without using the OR operator.
-- Concepts: IN operator, set membership filtering
SELECT * 
FROM cd.facilities 
WHERE facid IN (1, 5);


-- 7. Classify results into buckets
-- Question: How can you produce a list of facilities, with each labelled as 'cheap' 
--           or 'expensive' depending on if their monthlymaintenance is more than $100? 
--           Return the name and monthly maintenance of the facilities in question.
-- Concepts: CASE WHEN conditional expressions, column aliasing
SELECT name, 
       CASE 
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost
FROM cd.facilities;


-- 8. Working with dates
-- Question: How can you produce a list of members who joined after the start of September 2012? 
--           Return the memid, surname, firstname, and joindate of the members in question.
-- Concepts: Timestamp/date filtering with comparison operators
SELECT memid, surname, firstname, joindate 
FROM cd.members 
WHERE joindate >= '2012-09-01';


-- 9. Removing duplicates, and ordering results
-- Question: How can you produce an ordered list of the first 10 surnames in the members table? 
--           The list must not contain duplicates.
-- Concepts: DISTINCT deduplication, ORDER BY sorting, LIMIT row restricting
SELECT DISTINCT surname 
FROM cd.members 
ORDER BY surname 
LIMIT 10;


-- 10. Combining results from multiple queries
-- Question: You want a combined list of all surnames and all facility names.
-- Concepts: UNION operator (combining record sets with duplicate elimination)
SELECT surname 
FROM cd.members 
UNION 
SELECT name 
FROM cd.facilities;


-- 11. Simple aggregation
-- Question: You'd like to get the signup date of your last member. 
--           How can you retrieve this information?
-- Concepts: Aggregate function MAX()
SELECT MAX(joindate) AS latest 
FROM cd.members;


-- 12. More aggregation
-- Question: You'd like to get the first and last name of the last member(s) who signed up - not just the date. 
-- Concepts: Subqueries with aggregate functions, scalar subquery in WHERE
SELECT firstname, surname, joindate 
FROM cd.members 
WHERE joindate = (
    SELECT MAX(joindate) 
    FROM cd.members
);
