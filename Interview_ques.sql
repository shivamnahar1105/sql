-- # Ques1: From Product sales table I want data as :

-- | ProductID | ProductName | North | South | East | West |
-- |-----------|-------------|-------|-------|------|------|
-- | 1         | Product A   | 1000  | 2000  | NULL | 1700 |
-- | 2         | Product B   | 1500  | NULL  | 1800 | 1900 |
-- | 3         | Product C   | NULL  | 1200  | 1300 | NULL |

-- table creation query
-- CREATE TABLE ProductSales (
--     ProductID INT,
--     ProductName VARCHAR(50),
--     Region VARCHAR(50),
--     SaleAmount DECIMAL(10, 2)
-- );

-- INSERT INTO ProductSales (ProductID, ProductName, Region, SaleAmount)
-- VALUES
--     (1, 'Product A', 'North', 1000),
--     (2, 'Product B', 'North', 1500),
--     (1, 'Product A', 'South', 2000),
--     (3, 'Product C', 'South', 1200),
--     (2, 'Product B', 'East', 1800),
--     (3, 'Product C', 'East', 1300),
--     (1, 'Product A', 'West', 1700),
--     (2, 'Product B', 'West', 1900);

select * from ProductSales

-- Solution:
SELECT
    ProductID,
    ProductName,
    MAX(CASE WHEN Region = 'North' THEN SaleAmount END) AS North,
    MAX(CASE WHEN Region = 'South' THEN SaleAmount END) AS South,
    MAX(CASE WHEN Region = 'East' THEN SaleAmount END) AS East,
    MAX(CASE WHEN Region = 'West' THEN SaleAmount END) AS West
FROM
    ProductSales
GROUP BY
    ProductID,
    ProductName;
------------------------------------------------------------------
-- # Ques2: From TrainSchedule table I want data as :


-- Required Output
-- train_id	station	time	elapsed_travel_time	time_to_next_station
-- 110	A	10:00:00	0:00:00	0:54:00
-- 110	B	10:54:00	0:54:00	0:08:00
-- 110	C	11:02:00	1:02:00	1:33:00
-- 110	D	12:35:00	2:35:00	—
-- 120	A	11:00:00	0:00:00	0:54:00
-- 120	B	11:54:00	0:54:00	0:10:00
-- 120	C	12:04:00	1:04:00	1:26:00
-- 120	D	13:30:00	2:30:00	—

-- Table creation query

-- CREATE TABLE TrainSchedule (
--     train_id INT,
--     station VARCHAR(50),
--     station_time TIME
-- );

-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (110, 'A', '10:00:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (110, 'B', '10:54:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (110, 'C', '11:02:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (110, 'D', '12:35:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (120, 'A', '11:00:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (120, 'B', '11:54:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (120, 'C', '12:04:00');
-- INSERT INTO TrainSchedule (train_id, station, station_time) VALUES (120, 'D', '13:30:00');


-- Solution:
with cte as (
select *,
	station_time -min(station_time) over(partition by train_id order by station_time) as elapsed_travel_time,
	lead(station_time) over(partition by train_id order by station_time) as next_time
from trainschedule
)
select train_id, station, station_time, elapsed_travel_time,
		coalesce(next_time-station_time, '00:00:00') as time_to_next_station
from cte

------------------------------------------------------------------
-- # Ques3: From TrainSchedule table I want data as :

-- Input data
-- |----------------------------------------------|
--  service_name | updated_time      | status
-- |----------------------------------------------|
--  hdfs        | 24-03-06 10:00:00  |  up        |
--  hdfs        | 24-03-06 10:01:00  |  up        |
--  s3          | 24-03-06 10:01:00  |  up        |
--  s3          | 24-03-06 10:02:00  |  up        |
--  s3          | 24-03-06 10:03:00  |  up        |
--  hdfs        | 24-03-06 10:02:00  |  down      |
--  hdfs        | 24-03-06 10:03:00  |  down      |
--  hdfs        | 24-03-06 10:04:00  |  down      |
--  hdfs        | 24-03-06 10:05:00  |  down      |
--  s3          | 24-03-06 10:04:00  |  up        |
--  s3          | 24-03-06 10:05:00  |  down      |
--  s3          | 24-03-06 10:06:00  |  down      |
--  s3          | 24-03-06 10:07:00  |  down      |
--  s3          | 24-03-06 10:08:00  |  up        |
--  hdfs        | 24-03-06 10:06:00  |  down      |
--  hdfs        | 24-03-06 10:07:00  |  up        |
--  hdfs        | 24-03-06 10:08:00  |  up        |
--  hdfs        | 24-03-06 10:09:00  |  down      |
--  hdfs        | 24-03-06 10:10:00  |  down      |
--  s3          | 24-03-06 10:09:00  |  down      |
--  s3          | 24-03-06 10:10:00  |  down      |
--  s3          | 24-03-06 10:11:00  |  down      |
--  s3          | 24-03-06 10:12:00  |  down      |
--  s3          | 24-03-06 10:13:00  |  down      |
--  s3          | 24-03-06 10:14:00  |  up        |
-- |----------------------------------------------| 

-- Desired Output: Basically output tables gives only that data when a particular service 
-- has been down for more than 3 minutes.
-- |------------------------------------------------------------------------------------|
--  service_name   |     star_updated_time    |       end_updated_time      | status
-- |------------------------------------------------------------------------------------|
--   hdfs          |   24-03-06 10:02:00      |      24-03-06 10:06:00      | down      |   
--   s3            |   24-03-06 10:09:00      |      24-03-06 10:13:00      | down      |   
-- |------------------------------------------------------------------------------------|  

/*
-- Create the table
CREATE TABLE service_status (
    service_name VARCHAR(50),
    updated_time TIMESTAMP,
    status VARCHAR(10)
);

-- Insert the data
INSERT INTO service_status (service_name, updated_time, status) VALUES
('hdfs', '2024-03-06 10:00:00', 'up'),
('hdfs', '2024-03-06 10:01:00', 'up'),
('s3', '2024-03-06 10:01:00', 'up'),
('s3', '2024-03-06 10:02:00', 'up'),
('s3', '2024-03-06 10:03:00', 'up'),
('hdfs', '2024-03-06 10:02:00', 'down'),
('hdfs', '2024-03-06 10:03:00', 'down'),
('hdfs', '2024-03-06 10:04:00', 'down'),
('hdfs', '2024-03-06 10:05:00', 'down'),
('s3', '2024-03-06 10:04:00', 'up'),
('s3', '2024-03-06 10:05:00', 'down'),
('s3', '2024-03-06 10:06:00', 'down'),
('s3', '2024-03-06 10:07:00', 'down'),
('s3', '2024-03-06 10:08:00', 'up'),
('hdfs', '2024-03-06 10:06:00', 'down'),
('hdfs', '2024-03-06 10:07:00', 'up'),
('hdfs', '2024-03-06 10:08:00', 'up'),
('hdfs', '2024-03-06 10:09:00', 'down'),
('hdfs', '2024-03-06 10:10:00', 'down'),
('s3', '2024-03-06 10:09:00', 'down'),
('s3', '2024-03-06 10:10:00', 'down'),
('s3', '2024-03-06 10:11:00', 'down'),
('s3', '2024-03-06 10:12:00', 'down'),
('s3', '2024-03-06 10:13:00', 'down'),
('s3', '2024-03-06 10:14:00', 'up');

*/

-- Solution:
WITH status_changes AS (
  SELECT
    service_name,
    updated_time,
    status,
    LAG(status) OVER (PARTITION BY service_name ORDER BY updated_time) AS prev_status
  FROM
    service_status
)
, down_periods AS (
  SELECT
    service_name,
    updated_time AS start_updated_time,
    LEAD(updated_time) OVER (PARTITION BY service_name ORDER BY updated_time) AS end_updated_time,
    status, prev_status
  FROM
    status_changes
  WHERE
    (status = 'down' AND (prev_status IS NULL OR prev_status != 'down')) OR
    (status != 'down' AND prev_status = 'down')
)
SELECT
  service_name,
  start_updated_time,
  end_updated_time - INTERVAL '1 second' AS end_updated_time,
  status
FROM
  down_periods
WHERE
  status = 'down' AND end_updated_time - start_updated_time >INTERVAL '3 minutes';

