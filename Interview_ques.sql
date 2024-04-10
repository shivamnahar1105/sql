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
--     Train_id INT,
--     Station VARCHAR(50),
--     Time TIME
-- );
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (110, 'A', '10:00:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (110, 'B', '10:54:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (110, 'C', '11:02:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (110, 'D', '12:35:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (120, 'A', '11:00:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (120, 'B', '11:54:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (120, 'C', '12:04:00');
-- INSERT INTO TrainSchedule (Train_id, Station, Time) VALUES (120, 'D', '13:30:00');
