-- Create table in PostgreSQL

CREATE TABLE orders(
Id INT,
User_Id INT,
Total INT,
Created TIMESTAMP
);

-- Copy data from CSV file to PostgreSQL table 
COPY orders FROM 'C:\dump\excel\retention plot data.csv' WITH CSV HEADER;

-- Select all data from orders table
SELECT * FROM orders

-- Create 'grouped' table with user_id and date of created
CREATE TABLE grouped AS 
SELECT user_id, DATE(created) AS created_date 
FROM orders
GROUP BY user_id, DATE(created)
ORDER BY user_id;

SELECT * FROM grouped;

--Drop 'week' table if it exists and create it with specific columns
DROP TABLE IF EXISTS week;

CREATE TABLE week AS 
SELECT id, user_id, total, DATE_TRUNC('week', created) AS week_start 
FROM orders;

SELECT * FROM week;

-- ******************************************

-- Drop 'minweek' table if it exists and create it to track the first week_start date per user_id
DROP TABLE IF EXISTS minweek;

CREATE TABLE minweek AS 
SELECT user_id, MIN(week_start) AS min_week_start
FROM week 
GROUP BY user_id
ORDER BY min_week_start;

-- Get the first visit date per user_id
SELECT * FROM minweek
ORDER BY user_id;

-- *********************************

-- Drop 'final' table if it exists and create it with week difference calculation
DROP TABLE IF EXISTS final;

CREATE TABLE final AS 
SELECT g.user_id, g.created_date, m.min_week_start, 
       EXTRACT(DAY FROM g.created_date - m.min_week_start) / 7 AS week_difference 
FROM grouped AS g 
JOIN minweek AS m ON g.user_id = m.user_id;

SELECT * FROM final
ORDER BY min_week_start, week_difference;

-- **********************************

-- Generate a report showing counts for each week difference
SELECT min_week_start AS date_,
       COUNT(DISTINCT CASE WHEN week_difference = 0 THEN user_id END) AS week0,
       COUNT(DISTINCT CASE WHEN week_difference = 1 THEN user_id END) AS week1,
       COUNT(DISTINCT CASE WHEN week_difference = 2 THEN user_id END) AS week2,
       COUNT(DISTINCT CASE WHEN week_difference = 3 THEN user_id END) AS week3,
       COUNT(DISTINCT CASE WHEN week_difference = 4 THEN user_id END) AS week4,
       COUNT(DISTINCT CASE WHEN week_difference = 5 THEN user_id END) AS week5,
       COUNT(DISTINCT CASE WHEN week_difference = 6 THEN user_id END) AS week6,
       COUNT(DISTINCT CASE WHEN week_difference = 7 THEN user_id END) AS week7,
       COUNT(DISTINCT CASE WHEN week_difference = 8 THEN user_id END) AS week8,
       COUNT(DISTINCT CASE WHEN week_difference = 9 THEN user_id END) AS week9,
       COUNT(DISTINCT CASE WHEN week_difference = 10 THEN user_id END) AS week10
FROM final
GROUP BY min_week_start
ORDER BY min_week_start;

-- *************************
