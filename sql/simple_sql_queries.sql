-- ==============================================================================
-- PostgreSQL Exercises (pgexercises.com)
-- Section: Simple SQL Queries
-- Status: Completed (6 / 6 completed as per progress screenshot)
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
