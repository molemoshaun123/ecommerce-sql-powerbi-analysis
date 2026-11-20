-- ==============================================================================
-- PostgreSQL Exercises (pgexercises.com)
-- Section: Joins and Subqueries
-- Status: 100% Completed (8 / 8 completed as per progress screenshot)
-- Focus: Data Analyst Core - Multi-table Joins, Outer Joins, Self Joins & Subqueries
-- ==============================================================================

-- 1. Retrieve the start times of members' bookings
-- Question: How can you produce a list of the start times for bookings by 
--           members named 'David Farrell'?
-- Concepts: INNER JOIN across two tables, table aliasing, multiple WHERE filters
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


-- 4. Produce a list of all members, along with their recommender
-- Question: How can you output a list of all members, including the individual who 
--           recommended them (if any)? Ensure that results are ordered by (surname, firstname).
-- Concepts: LEFT OUTER JOIN (preserves members without recommenders), NULL handling in joins
SELECT mems.firstname AS memfname, 
       mems.surname   AS memsname, 
       recs.firstname AS recfname, 
       recs.surname   AS recsname
FROM cd.members mems
LEFT OUTER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY memsname, memfname;


-- 5. Produce a list of all members who have used a tennis court
-- Question: How can you produce a list of all members who have used a tennis court? 
--           Include the name of the facility and the member name formatted as a single column.
--           Ensure no duplicates, ordered by member name then facility name.
-- Concepts: 3-Table INNER JOIN (members -> bookings -> facilities), string concatenation (||), DISTINCT
SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member, 
       facs.name AS facility
FROM cd.members mems
INNER JOIN cd.bookings bks
    ON mems.memid = bks.memid
INNER JOIN cd.facilities facs
    ON bks.facid = facs.facid
WHERE facs.name LIKE 'Tennis Court%'
ORDER BY member, facility;


-- 6. Produce a list of costly bookings
-- Question: How can you produce a list of bookings on 2012-09-14 which cost more than $30? 
--           Guests (ID 0) pay guestcost; members pay membercost. 
--           Output facility name, member name, and cost. Order by descending cost without subqueries.
-- Concepts: Multi-table JOIN, CASE WHEN expression on join attributes, conditional cost calculation
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


-- 7. Produce a list of all members, along with their recommender, using no joins
-- Question: How can you output a list of all members, including the individual who 
--           recommended them (if any), without using any joins? 
--           Format each result as a single column 'firstname surname', ordered by member.
-- Concepts: Scalar correlated subquery in SELECT projection list (replacing an outer join)
SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member,
       (SELECT recs.firstname || ' ' || recs.surname 
        FROM cd.members recs 
        WHERE recs.memid = mems.recommendedby) AS recommender
FROM cd.members mems
ORDER BY member;


-- 8. Produce a list of costly bookings, using a subquery
-- Question: Rewrite the costly bookings query to avoid duplicate cost logic by using a subquery.
-- Concepts: Inline subquery (derived table) in FROM clause, eliminating DRY violations
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
