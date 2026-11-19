-- ==============================================================================
-- PostgreSQL Exercises (pgexercises.com)
-- Section: Joins and Subqueries
-- Status: In Progress (3 completed as per progress screenshot)
-- ==============================================================================

-- 1. Retrieve the start times of members' bookings
-- Question: How can you produce a list of the start times for bookings by 
--           members named 'David Farrell'?
-- Concepts: INNER JOIN across multiple tables, table aliasing, multi-column filtering
SELECT bks.starttime
FROM cd.bookings bks
INNER JOIN cd.members mems
    ON mems.memid = bks.memid
WHERE mems.firstname = 'David'
  AND mems.surname = 'Farrell';


-- 2. Work out the start times of bookings for tennis courts
-- Question: How can you produce a list of the start times for bookings for 
--           tennis courts, for the date '2012-09-21'? Return a list of start time 
--           and facility name matches, ordered by time.
-- Concepts: INNER JOIN, timestamp date range filtering, pattern matching (LIKE), ORDER BY
SELECT bks.starttime AS start, 
       facs.name AS name
FROM cd.bookings bks
INNER JOIN cd.facilities facs
    ON facs.facid = bks.facid
WHERE facs.name LIKE 'Tennis Court%'
  AND bks.starttime >= '2012-09-21'
  AND bks.starttime < '2012-09-22'
ORDER BY bks.starttime;


-- 3. Produce a list of all members who have recommended another member
-- Question: How can you output a list of all members who have recommended another member? 
--           Ensure that there are no duplicates in the list, and that results 
--           are ordered by (surname, firstname).
-- Concepts: Self JOIN (cd.members joining on itself), DISTINCT deduplication, multi-column sorting
SELECT DISTINCT recs.firstname, 
       recs.surname
FROM cd.members mems
INNER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY surname, firstname;
