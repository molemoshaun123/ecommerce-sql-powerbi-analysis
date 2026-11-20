-- ==============================================================================
-- PostgreSQL Exercises (pgexercises.com)
-- Section: Aggregation
-- Status: Completed for Day 1 SQL Refresh (9 completed as per progress screenshot)
-- Focus: Data Analyst Core - COUNT, SUM, GROUP BY, HAVING, EXTRACT(month), DISTINCT
-- ==============================================================================

-- 1. Count the number of facilities
-- Question: We want to know how many facilities exist - simply produce a total count.
-- Concepts: Basic COUNT(*) aggregate function
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
--           Sorted by facility id.
-- Concepts: SUM() aggregate function over groups, GROUP BY on foreign key, ORDER BY
SELECT facid,
       SUM(slots) AS Total_slots
FROM cd.bookings
GROUP BY facid
ORDER BY facid;


-- 5. List the total slots booked per facility in a given month
-- Question: Produce a list of the total number of slots booked per facility in the 
--           month of September 2012. Sorted by total slots.
-- Concepts: Date range filtering with aggregates, SUM() with GROUP BY and ORDER BY
SELECT facid, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-09-01'
  AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY SUM(slots);


-- 6. List the total slots booked per facility per month
-- Question: Produce a list of the total number of slots booked per facility per month in 2012. 
--           Sorted by facility id and month.
-- Concepts: EXTRACT(month FROM timestamp), multi-column GROUP BY, date aggregation
SELECT facid, 
       EXTRACT(month FROM starttime) AS month, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-01-01'
  AND starttime < '2013-01-01'
GROUP BY facid, month
ORDER BY facid, month;


-- 7. Find the count of members who have made at least one booking
-- Question: Find the count of members who have made at least one booking.
-- Concepts: COUNT(DISTINCT column) to count unique entities in transactional records
SELECT COUNT(DISTINCT memid) 
FROM cd.bookings;


-- 8. List facilities with more than 1000 slots booked
-- Question: Produce a list of facilities with more than 1000 slots booked. 
--           Sorted by facility id.
-- Concepts: HAVING clause to filter aggregate values (post-aggregation filtering)
SELECT facid, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;


-- 9. Output the facility id that has the highest number of slots booked
-- Question: Output the facility id that has the highest number of slots booked.
-- Concepts: GROUP BY, ORDER BY aggregated expression DESC, LIMIT 1 (top-N query)
SELECT facid, 
       SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
ORDER BY SUM(slots) DESC
LIMIT 1;
