-- ==============================================================================
-- PostgreSQL Exercises (pgexercises.com)
-- Section: Aggregation
-- Status: In Progress (4 completed as per user answers & progress screenshot)
-- Focus: Data Analyst Core - COUNT, SUM, Filtering with Aggregates, GROUP BY
-- ==============================================================================

-- 1. Count the number of facilities
-- Question: For our first foray into aggregates, we're going to stick to something simple. 
--           We want to know how many facilities exist - simply produce a total count.
-- Concepts: Basic COUNT(*) aggregate function, aliasing
SELECT count(*) AS Total_facilities
FROM cd.facilities;


-- 2. Count the number of expensive facilities
-- Question: Produce a count of the number of facilities that have a cost to guests of 10 or more.
-- Concepts: Combining WHERE condition filtering with aggregate COUNT(*)
SELECT count(*) AS number_facilities
FROM cd.facilities
WHERE guestcost >= 10;


-- 3. Count the number of recommendations each member makes
-- Question: Produce a count of the number of recommendations each member has made. 
--           Order by member ID.
-- Concepts: GROUP BY aggregation, IS NOT NULL filtering, ORDER BY sorting
SELECT recommendedby,
       count(*)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;


-- 4. List the total slots booked per facility
-- Question: Produce a list of the total number of slots booked per facility. 
--           For now, just produce an output table consisting of facility id and slots, 
--           sorted by facility id.
-- Concepts: SUM() aggregate function over groups, GROUP BY on foreign key, ORDER BY
SELECT facid,
       SUM(slots) AS Total_slots
FROM cd.bookings
GROUP BY facid
ORDER BY facid;
