# 	Q51.

-- create table if not exists World
-- (
--     name VARCHAR(50),
--     continent varchar(50),
--     area int,
--     population bigint,
--     gdp bigint,
--     constraint pk PRIMARY KEY (name)
-- );

-- insert into World VALUES ('Afghanistan','Asia',652230,25500100,20343000000),
-- ('Albania','Europe',28748,2831741,12960000000),
-- ('Algeria','Africa',2381741,37100000,188681000000),
-- ('Andorra','Europe',468,78115,3712000000),
-- ('Angola','Africa',1246700,20609294,100990000000);

-- select * from World;

-- select name, population, area from World
-- where area >= 3000000 or population >=25000000


# Q52.

-- create table if not exists Customer
-- (
--     id int,
--     name varchar(50),
--     referee_id int,
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Customer VALUES (1,'Will',null),(2,'Jane',null),(3,'Alex',2),(4,'Bill',null),(5,'Zack',1),(6,'Mark',2);
-- select * from Customer;

-- SELECT name from Customer
-- where referee_id != 2 
-- OR referee_id IS NULL;

# Q53.

--  create table if not exists customers(
--  id int,
--  name VARCHAR(250),
--  PRIMARY KEY (id)
--  );

-- create TABLE if not exists orders(
--  id int,
--  customerid int,
--  PRIMARY KEY (id),
--  constraint fk FOREIGN KEY (customerid) REFERENCES customers(id)
-- );

-- insert into customers VALUES (1,'Joe'),(2,'Henry'),(3,'Sam'),(4,'Max');

-- select * from customers;

-- insert into orders VALUES (1,3),(2,1);

-- select * from orders;

-- #Approach-1
-- select name from customers 
-- where id not in (select customerid from orders );

-- #Approach-2
-- select name from customers c left join orders o
-- on c.id = o.customerid where o.customerid is null

# Q54.
-- create table if not exists Employee
-- (
--     employee_id int,
--     team_id int,
--     constraint pk PRIMARY KEY (employee_id)
-- );

-- insert into Employee VALUES (1,8),(2,8),(3,8),(4,7),(5,9),(6,9);

-- select * from Employee;

-- SELECT employee_id, count(team_id) over(PARTITION BY team_id ) as team_size from Employee
-- order by employee_id ;

# Q55.
-- create table if not exists Person
-- (
--     id int,
--     name VARCHAR(50),
--     phone_number VARCHAR(50),
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Person VALUES (3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),(1,'Moncef','212-1234567'),(2,'Maroua','212-6523651'),(7,'Meir','972-1234567'),(9,'Rachel','972-0011100');

-- select * from Person;


-- create table if not exists Country
-- (
--     name VARCHAR(50),
--     country_code VARCHAR(50),
--     constraint pk PRIMARY KEY (country_code)
-- );

-- insert into Country VALUES ('Peru',51),('Israel',972),('Morocco',212),('Germany',49),('Ethiopia',251);

-- select * from Country;

-- create table if not exists Calls
-- (
--     caller_id int,
--     callee_id int,
--     duration int
-- );

-- insert into Calls VALUES (1,9,33),(2,9,4),(1,2,59),(3,12,102),(3,12,330),(12,3,5),(7,9,13),(7,1,3),(9,7,1),(1,7,7);

-- select * from Calls;

-- with country_phone as (SELECT p.*, c.name as country_name FROM person p JOIN
-- (SELECT name, 
-- CASE
--     WHEN LENGTH(country_code) < 3 then CONCAT("0", country_code)
--     else country_code
-- end as new_code
-- FROM country) as c 
-- ON
--     left(p.phone_number, 3) = c.new_code
-- )

-- SELECT country_name, sum(total_dur)/sum(total_count) as final FROM 
-- (SELECT cp.country_name, (2 * cal.duration) as total_dur,  (2 * count(cp.country_name)) as total_count FROM calls as cal
-- JOIN
--     country_phone as cp
-- ON
--     cal.caller_id = cp.id
-- GROUP BY cp.country_name, duration) as tmp
-- GROUP BY country_name ORDER BY final DESC LIMIT 1


# Q56.

-- create table if not exists Activity
-- (
--     player_id int,
--     device_id int,
--     event_date date,
--     games_played int,
--     constraint pk PRIMARY KEY (player_id, event_date)
-- );

-- insert into Activity VALUES (1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

-- select * from Activity;

-- SELECT player_id,device_id FROM (SELECT player_id,device_id, 
-- ROW_NUMBER() OVER(PARTITION BY player_id order by event_date) as rnk from Activity) TMP

-- WHERE TMP.rnk = 1

# Q57.

-- create table if not exists Orders
-- (
--     order_number int,
--     customer_number int,
--     constraint pk PRIMARY KEY (order_number)
-- );

-- insert into Orders VALUES (1,1),(2,2),(3,3),(4,3);

-- select * from Orders;

-- select customer_number
-- FROM Orders
-- group by customer_number
-- order by count(*) DESC
-- LIMIT 1;


# 58.
-- create table if not exists Cinema
-- (
--     seat_id int AUTO_INCREMENT,
--     free bool,
--     constraint pk PRIMARY KEY (seat_id)
-- );

-- insert into Cinema VALUES (1,1),(2,0),(3,1),(4,1),(5,1);

-- select * from Cinema;
--  

-- select DISTINCT c1.seat_id from Cinema c1
-- INNER JOIN Cinema c2
-- on abs (c1.seat_id - c2.seat_id) = 1
-- and 
-- c1.free = 1 and c2.free = 1
-- ORDER BY 1;

# Q59. 

-- create table if not exists SalesPerson
-- (
--     sales_id int,
--     name VARCHAR(50),
--     salary int,
--     commission_rate int,
--     hire_date date,
--     constraint pk PRIMARY KEY (sales_id)
-- );

-- INSERT into SalesPerson VALUES (1,'John',100000,6,'2006-04-01'),(2,'Amy',12000,5,'2010-05-01'),(3,'Mark',65000,12,'2008-12-25'),
-- (4,'Pam',25000,25,'2005-01-01'),(5,'Alex',5000,10,'2007-02-03');


-- select * from SalesPerson;


-- create table if not exists Company
-- (
--     com_id int,
--     name VARCHAR(50),
--     city VARCHAR(50),
--     constraint pk PRIMARY KEY (com_id)
-- );

-- insert into Company VALUES (1,'RED','Boston'),(2,'ORANGE','New York'),(3,'YELLOW','Boston'),(4,'GREEN','Austin');

-- select * from Company;

-- create table if not exists Orders
-- (
--     order_id int,
--     order_date DATE,
--     com_id int,
--     sales_id int,
--     amount int,
--     constraint pk PRIMARY KEY (order_id),
--     constraint fk1 FOREIGN KEY (com_id) REFERENCES Company(com_id),
--     constraint fk2 FOREIGN KEY (sales_id) REFERENCES SalesPerson(sales_id)
-- );


-- insert into Orders VALUES (1,'2014-01-01',3,4,10000),(2,'2014-02-01',4,5,5000),(3,'2014-03-01',1,1,50000),(4,'2014-04-01',1,4,25000);

-- select * from Orders;

-- SELECT name
-- FROM Salesperson
-- WHERE sales_id
-- NOT IN (
--     SELECT s.sales_id FROM Orders o
--     INNER JOIN Salesperson s ON o.sales_id = s.sales_id
--     INNER JOIN Company c ON o.com_id = c.com_id
--     WHERE c.name = 'RED'
-- );

# Q60. 

-- create table if not exists Triangle
-- (
--     x int,
--     y int,
--     z int,
--     constraint pk PRIMARY KEY (x,y,z)
-- );

-- insert into Triangle VALUES (13,15,30),(10,20,15);

-- select * from Triangle;

-- Select x, y, z, 
--    (case
--         when x+y < z or x+z < y or y+z < x then "No"
--         when x=y and y=z then "Yes"
--         when x=y or x=z or y=z then "Yes"
--         when x<>y and y<>z then "Yes" end ) triangle
-- from Triangle

# Q61.

-- create table if not exists Point
-- (
--     x int,
--     constraint pk PRIMARY KEY (x)
-- );

-- insert into Point VALUES (-1),(0),(2);

-- select * from Point;

-- select min(abs(p2.x-p1.x)) as shortest
-- from Point p1, Point p2
-- where p1.x != p2.x;

# Q62.
-- create table if not exists ActorDirector
-- (
--     actor_id int,
--     director_id int,
--     timestamp int,
--     constraint pk PRIMARY KEY (timestamp)
-- );


-- insert into ActorDirector VALUES (1,1,0),(1,1,1),(1,1,2),(1,2,3),(1,2,4),(2,1,5),(2,1,6);

-- select * from ActorDirector;

-- SELECT actor_id, director_id 
-- FROM ActorDirector
-- GROUP BY actor_id,director_id
-- HAVING COUNT(actor_id) >=3

# Q63.
-- create table if not exists Product
-- (
--     product_id int,
--     product_name varchar(50),
--     constraint pk PRIMARY KEY (product_id)
-- );

-- insert into Product VALUES (100,'Nokia'),(200,'Apple'),(300,'Samsung');

-- select * from Product;

-- create table if not exists Sales
-- (
--     sale_id int,
--     product_id int,
--     year int,
--     quantity int,
--     price int,
--     constraint pk PRIMARY KEY (sale_id, year),
--     constraint fk FOREIGN KEY (product_id) REFERENCES Product(product_id)
-- );

-- insert into Sales VALUES (1,100,2008,10,5000),(2,100,2009,12,5000),(7,200,2011,15,9000);

-- select * from Sales;

-- SELECT P.product_name,S.year, S.price 
-- FROM Product P INNER JOIN Sales S
-- ON P.product_id = S.product_id


# Q64.

-- create table if not exists Employee
-- (
--     employee_id int,
--     name varchar(50),
--     experience_years int,
--     constraint pk PRIMARY KEY (employee_id)
-- );

-- insert into Employee VALUES (1,'Khaled',3),(2,'Ali',2),(3,'John',1),(4,'Doe',2);

-- select * from Employee;

-- create table if not exists Project
-- (
--     project_id int,
--     employee_id int,
--     constraint pk PRIMARY KEY (project_id, employee_id),
--     constraint fkp FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)

-- );

-- insert into Project VALUES (1,1),(1,2),(1,3),(2,1),(2,4);

-- select * from Project;

-- SELECT project_id, ROUND(AVG(experience_years),2) AS avg_years FROM Employee E LEFT JOIN Project P
-- ON E.employee_id = P.employee_id
-- GROUP BY project_id

# Q65.

-- CREATE TABLE IF NOT EXISTS product(
-- 	product_id int,
--     product_name VARCHAR(50),
--     unit_price int,
--     PRIMARY KEY (product_id)
-- );

-- INSERT INTO product VALUES 
-- (1,'S8',1000),
-- (2,'G4',800),
-- (3,'iPhone',1400);

-- SELECT * FROM product;

-- create table if not exists sales
-- (
--     seller_id int,
--     product_id int,
--     buyer_id int,
--     sale_date date,
--     quantity int,
--     price int,
--     constraint fk FOREIGN KEY (product_id) REFERENCES Product(product_id)
-- );

-- insert into sales VALUES (1,1,1,'2019-01-21',2,2000),(1,2,2,'2019-02-17',1,800),(2,2,3,'2019-06-02',1,800),(3,3,4,'2019-05-13',2,2800);

-- select * from sales;

-- SELECT DISTINCT t.seller_id from (select seller_id, sum(price) over(partition by seller_id) as total_Sales from sales s inner join product p
-- on s.product_id = p.product_id) t 
-- where t.total_Sales = 2800;

# Q66.

-- select buyer_id from sales s inner join product p
-- on s.product_id = p.product_id
-- where product_name = 'S8'
-- and buyer_id not in
-- (
-- select buyer_id from sales s
--     join product p on p.product_id = s.product_id
--     where p.product_name = 'iPhone'
-- );

# Q67.

-- create table if not exists Customer
-- (
--     customer_id int,
--     name VARCHAR(50),
--     visited_on date,
--     amount int,
--     constraint pk PRIMARY KEY (customer_id, visited_on)
-- );

-- INSERT into Customer VALUES (1,'Jhon','2019-01-01',100),(2,'Daniel','2019-01-02',110),(3,'Jade','2019-01-03',120),(4,'Khaled','2019-01-04',130),(5,'Winston','2019-01-05',110),(6,'Elvis','2019-01-06',140),(7,'Anna','2019-01-07',150),(8,'Maria','2019-01-08',80),(9,'Jaze','2019-01-09',110),(1,'Jhon','2019-01-10',130),(3,'Jade','2019-01-10',150);

-- select * from Customer;

-- with cte as (
-- 			SELECT visited_on,
--             sum(amount) AS total_amount FROM
--             Customer
--             GROUP BY visited_on
--             ORDER BY visited_on

-- ) ,
-- cte2 as (

-- SELECT visited_on,
-- SUM(total_amount) over(rows BETWEEN 6 preceding and current row) as amount,
-- round(avg(total_amount) over(rows BETWEEN 6 preceding and current row),2) as average_amount,
-- dense_rank() over(order by visited_on) as rnk
-- FROM cte
-- )

-- Select visited_on, amount, average_amount from cte2
-- where rnk > 6;


# Q68.
-- create table if not exists Scores
-- (
--     player_name VARCHAR(50),
--     gender varchar(50),
--     day date,
--     score_points int,
--     constraint pk PRIMARY KEY (gender, day)
-- );

-- insert into Scores VALUES ('Aron','F','2020-01-01',17),('Alice','F','2020-01-07',23),('Bajrang','M','2020-01-07',7),('Khali','M','2019-12-25',11),('Slaman','M','2019-12-30',13),('Joe','M','2019-12-31',3),('Jose','M','2019-12-18',2),('Priya','F','2019-12-31',23),('Priyanka','F','2019-12-30',17);

-- select * from Scores
-- ORDER BY day ;

-- SELECT gender,day, sum(score_points) over(PARTITION BY gender order by day ) as total from Scores

# Q69.
-- create table if not exists Logs
-- (
--     log_id int,
--     constraint pk PRIMARY KEY (log_id)
-- );

-- insert into Logs VALUES (1),(2),(3),(7),(8),(10);

-- select * from Logs;
-- select min(log_id) as start_id, max(log_id) as end_id
-- from (select l.log_id, (l.log_id - l.row_num) as diff
--       from (select log_id, row_number() over() as row_num from Logs) l
--       ) l2
-- group by diff;

# Q70.
-- create table if not exists Students
-- (
--     student_id int,
--     student_name VARCHAR(50),
--     constraint pk PRIMARY KEY (student_id)
-- );

-- insert into Students VALUES (1,'Alice'),(2,'Bob'),(13,'John'),(6,'Alex');

-- select * from Students;


-- create table if not exists Subjects
-- (
--     subject_name VARCHAR(50),
--     constraint pk PRIMARY KEY (subject_name)
-- );

-- insert into Subjects VALUES ('Math'),('Physics'),('Programming');

-- select * from Subjects;


-- create table if not exists Examinations
-- (
--     student_id int,
--     subject_name VARCHAR(50)
-- );

-- INSERT into Examinations VALUES (1,'Math'),(1,'Physics'),(1,'Programming'),(2,'Programming'),(1,'Physics'),(1,'Math'),(13,'Math'),(13,'Programming'),(13,'Physics'),(2,'Math'),(1,'Math');

-- select * from Examinations;

-- select a.student_id, b.subject_name, count(b.subject_name) as attended_exams
-- from Students as a
-- join Subjects as b
-- left join Examinations as c
-- on a.student_id = c.student_id and b.subject_name = c.subject_name
-- group by a.student_id, b.subject_name;

# Q71.
-- create table if not exists Employees
-- (
--     employee_id int,
--     employee_name VARCHAR(50),
--     manager_id int,
--     constraint pk PRIMARY KEY (employee_id)
-- );

-- insert into Employees VALUES (1,'Boss',1),(3,'Alice',3),(2,'Bob',1),(4,'Daniel',2),(7,'Luis',4),(8,'Jhon',3),(9,'Angela',8),(77,'Robert',1);

-- select * from Employees;


-- select e3.employee_id from Employees e1, Employees e2, Employees e3
-- where e1.manager_id = 1 and e2.manager_id = e1.employee_id and e3.manager_id = e2.employee_id and e3.employee_id != 1;

# Q72.

-- create table if not exists Transactions
-- (
--     id int,
--     country VARCHAR(50),
--     state enum('approved', 'declined'),
--     amount int,
--     trans_date date,
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Transactions VALUES (121,'US','approved',1000,'2018-12-18'),(122,'US','declined',2000,'2018-12-19'),
-- (123,'US','approved',2000,'2019-01-01'),(124,'DE','approved',2000,'2019-01-07');


-- select * from Transactions;

-- select country,
-- DATE_FORMAT(trans_date, '%Y-%m') AS month,
-- sum(amount) as trans_total_amount,
-- sum(if(state = 'approved', amount, 0)) as approved_total_amount,
-- count(if(state = 'approved', state, NULL)) as approved_count,
-- count(id) as trans_count
-- from Transactions
-- GROUP BY  month, country;

# Q73.

-- create table if not exists Actions
-- (
--     user_id int,
--     post_id int,
--     action_date date,
--     action enum('view', 'like', 'reaction', 'comment', 'report', 'share'),
--     extra VARCHAR(50)
-- );

-- insert into Actions VALUES (1,1,'2019-07-01','view',null),(1,1,'2019-07-01','like',null),(1,1,'2019-07-01','share',null),(2,2,'2019-07-04','view',null),(2,2,'2019-07-04','report','spam'),(3,4,'2019-07-04','view',null),(3,4,'2019-07-04','report','spam'),(4,3,'2019-07-02','view',null),(4,3,'2019-07-02','report','spam');

-- select * from Actions;

-- create table if not exists Removals
-- (
--     post_id int,
--     remove_date date,
--     constraint pk PRIMARY KEY (post_id)
-- );

-- insert into Removals VALUES (2,'2019-07-20'),(3,'2019-07-18');

-- select * from Removals;

-- SELECT * FROM Actions a  INNER JOIN Removals r
-- ON a.post_id = r.post_id;

-- SELECT ROUND(AVG(percentage),2) AS average_daily_percent
-- FROM (
-- SELECT action_date, 
-- (COUNT(DISTINCT b.post_id)/COUNT(DISTINCT a.post_id))*100 AS percentage 
-- FROM Actions AS a
-- LEFT JOIN Removals AS b
-- ON a.post_id = b.post_id
-- WHERE a.action = 'report'
-- AND a.extra = 'spam'
-- GROUP BY a.action_date
-- ) AS tmp;

# Q74.

-- create table if not exists Activity
-- (
--     player_id int,
--     device_id int,
--     event_date date,
--     games_played int,
--     constraint pk PRIMARY KEY (player_id, event_date)
-- );

-- insert into Activity VALUES (1,2,'2016-03-01',5),(1,2,'2016-03-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

-- select * from Activity;

-- select player_id, abs(min(event_date) - max(event_date)) as diff 
-- from Activity
-- GROUP BY player_id;

-- select player_id, min(event_date),max(event_date)
-- from Activity
-- GROUP BY player_id;

-- with temp as (

-- select player_id, abs(min(event_date) - max(event_date)) as diff 
-- from Activity
-- GROUP BY player_id

-- )
-- SELECT 
-- round((count(distinct c.player_id)/ (select count(distinct player_id) from Activity)),2) as fraction
-- from temp c
-- inner join Activity a
-- on c.player_id = a.player_id
-- where c.diff = 1;

# Q75.
-- create table if not exists Activity
-- (
--     player_id int,
--     device_id int,
--     event_date date,
--     games_played int,
--     constraint pk PRIMARY KEY (player_id, event_date)
-- );

-- insert into Activity VALUES (1,2,'2016-03-01',5),(1,2,'2016-03-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

-- select * from Activity;

-- select player_id, abs(min(event_date) - max(event_date)) as diff 
-- from Activity
-- GROUP BY player_id;

-- select player_id, min(event_date),max(event_date)
-- from Activity
-- GROUP BY player_id;

-- with temp as (

-- select player_id, abs(min(event_date) - max(event_date)) as diff 
-- from Activity
-- GROUP BY player_id

-- )
-- SELECT 
-- round((count(distinct c.player_id)/ (select count(distinct player_id) from Activity)),2) as fraction
-- from temp c
-- inner join Activity a
-- on c.player_id = a.player_id
-- where c.diff = 1;


# Q76.

-- create table if not exists Salaries
-- (
--     company_id int,
--     employee_id int,
--     employee_name VARCHAR(50),
--     salary int,
--     constraint pk PRIMARY KEY (company_id, employee_id)
-- );

-- insert into Salaries VALUES (1,1,'Tony',2000),(1,2,'Pronub',21300),(1,3,'Tyrrox',10800),(2,1,'Pam',300),
-- (2,7,'Bassem',450),(2,9,'Hermione',700),(3,7,'Bocaben',100),(3,2,'Ognjen',2200),(3,13,'Nyan Cat',3300),(3,15,'Morning Cat',7777);


-- SELECT * FROM Salaries;

-- with cte as (
-- SELECT *,max(salary) over(partition by company_id ) as max_salary FROM Salaries
-- )
-- SELECT company_id, employee_id, employee_name,
-- (CASE WHEN max_salary < 1000 THEN salary
-- 	 WHEN max_salary >= 1000 AND max_salary<=10000 THEN round((salary - (.24)*salary))
-- 	 ELSE round((salary - (.49)*salary)) END) salary
-- FROM cte

# Q77.

-- create table if not exists Variables
-- (
--     name varchar(50),
--     value int,
--     constraint pk PRIMARY KEY (name)
-- );

-- insert into Variables VALUES ('x',66),('y',77);

-- select * from Variables;

-- create table if not exists Expressions
-- (
--     left_operand varchar(50),
--     operator enum ('<', '>', '='),
--     right_operand VARCHAR(50),
--     constraint pk PRIMARY KEY (left_operand, operator, right_operand)
-- );


-- insert into Expressions VALUES ('x','>','y'),('x','<','y') ,('x','=','y'),('y','>','x'),('y','<','x'),('x','=','x');   

-- select * from Expressions;


-- WITH cte as (

-- select * from Expressions
-- )
-- SELECT *,
-- CASE
--     when operator = "<" and (left_operand < right_operand) = 1 then "true"
--     when operator = ">" and (left_operand > right_operand) = 1 then "true"
--     when operator = "=" and (left_operand = right_operand) = 1 then "true"
--     else "false"
-- end as value
-- FROM CTE;

# Q78.
-- create table if not exists Person
-- (
--     id int,
--     name VARCHAR(50),
--     phone_number VARCHAR(50),
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Person VALUES (3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),(1,'Moncef','212-1234567'),(2,'Maroua','212-6523651'),(7,'Meir','972-1234567'),(9,'Rachel','972-0011100');


-- select * from Person;


-- create table if not exists Country
-- (
--     name VARCHAR(50),
--     country_code VARCHAR(50),
--     constraint pk PRIMARY KEY (country_code)
-- );

-- insert into Country values ('Peru',51),('Israel',972),('Morocco',212),('Germany',49),('Ethiopia',251);

-- select * from Country;


-- create table if not exists Calls
-- (
--     caller_id int,
--     callee_id int,
--     duration int
-- );

-- insert into Calls VALUES (1,9,33),(2,9,4),(1,2,59),(3,12,102),(3,12,330),(12,3,5),(7,9,13),(7,1,3),(9,7,1),(1,7,7);

-- select * from Calls;

-- with country_phone as (SELECT p.*, c.name as country_name FROM person p JOIN
-- (SELECT name, 
-- CASE
--     WHEN LENGTH(country_code) < 3 then CONCAT("0", country_code)
--     else country_code
-- end as new_code
-- FROM country) as c 
-- ON
--     SUBSTRING(p.phone_number,1,3) = c.new_code
-- )
-- SELECT
--  p.country_name AS country,AVG(duration)
-- FROM
--  country_phone p
--  JOIN
--      Calls c
--      ON p.id IN (c.caller_id, c.callee_id)
-- GROUP BY
--  p.country_name
-- HAVING
--  AVG(duration) > (SELECT AVG(duration) FROM Calls);

# Q79.

--  create table if not exists Employee
-- (
--     employee_id int,
--     name VARCHAR(50),
--     months int,
--     salary int
-- );


-- insert into Employee VALUES (12228,'Rose',15,1968),(33645,'Angela',1,3443),(45692,'Frank',17,1608),
-- (56118,'Patrick',7,1345),(59725,'Lisa',11,2330),(74197,'Kimberly',16,4372),(78454,'Bonnie',8,1771),
-- (83565,'Michael',6,2017),(98607,'Todd',5,3396),(99989,'Joe',9,3573);

-- select * from Employee;

--  SELECT name from Employee order by name;

# Q80.

-- create table if not exists user_transactions
-- (
--     transaction_id int,
--     product_id int,
--     spend decimal (7,2),
--     transaction_date DATETIME
-- );

-- #YYYY-MM-DD hh:mm:ss -datetime 

-- insert into user_transactions VALUES (1341,123424,1500.60,'2019-12-31 12:00:00'),(1423,123424,1000.20,'2020-12-31 12:00:00'),
-- (1623,123424,1246.44,'2021-12-31 12:00:00'),(1322,123424,2145.32,'2022-12-31 12:00:00');

-- select * from user_transactions;

-- select product_id, spend as curr_year_spend, 
-- lag(spend,1) over(order by extract(YEAR FROM transaction_date)) AS prev_year_spend,
-- round(((spend - lag(spend,1) over(order by extract(YEAR FROM transaction_date)))/lag(spend,1) over(order by extract(YEAR FROM transaction_date))) * 100,2) as yoy_rate

-- from user_transactions;

# Q81.

-- create table if not exists inventory
-- (
--     item_id int,
--     item_type VARCHAR(50),
--     item_category VARCHAR(50),
--     square_footage DECIMAL(4,2)
-- );

-- insert into inventory VALUES (1374,'prime_eligible','mini refrigerator',68.00),(4245,'not_prime','standing lamp',26.40),
-- (2452,'prime_eligible','television',85.00),(3255,'not_prime','side table',22.60),(1672,'prime_eligible','laptop',8.50);

-- select * from inventory;

-- WITH product_inventory_summary AS
-- (
--   SELECT
--     item_type,
--     SUM(square_footage) as square_footage_required,
--     COUNT(item_id) as unique_item_count,
--     500000 as total_space,
--     FLOOR(500000/sum(square_footage))*sum(square_footage) as space_used,
--     FLOOR(500000/sum(square_footage))*COUNT(item_id) as item_count
--   FROM 
--     inventory
--   GROUP BY 
--     item_type
-- )
-- SELECT 
--   t1.item_type,
--   CASE
--     WHEN t1.item_type = 'prime_eligible'
--       THEN t1.item_count
--     ELSE
--       FLOOR((500000-t2.space_used)/t1.square_footage_required)*t1.unique_item_count
--   END AS item_count
-- FROM
--   product_inventory_summary t1
--   JOIN product_inventory_summary t2 ON t1.item_type <> t2.item_type
-- ORDER BY t1.item_type DESC

# Q82.
-- CREATE TABLE user_actions
-- (
--   user_id INT,
--   event_id INT,
--   event_type VARCHAR(20),
--   event_date DATE
-- );

-- INSERT INTO user_actions VALUES(445, 7765 , 'sign-in', '2022-05-31');
-- INSERT INTO user_actions VALUES(742, 6458, 'sign-in', '2022-06-03');
-- INSERT INTO user_actions VALUES(445, 3634, 'like', '2022-06-05');
-- INSERT INTO user_actions VALUES(742, 1374, 'comment', '2022-06-05');
-- INSERT INTO user_actions VALUES(648, 3124, 'like', '2022-06-18');

-- select * from user_actions;

-- with temp as	(SELECT *, count(user_id) over(PARTITION BY user_id) as t_count,
-- 	lag(event_date, 1) over() as new_col
-- 	from user_actions)
--     
-- select distinct extract(month from t.event_date) as month,
-- count(t.user_id)  as monthly_active_users
-- from temp t
-- where abs(extract(month from t.new_col) - extract(month from t.event_date)) = 1
-- group by extract(month from t.event_date)

# Q85.
-- CREATE TABLE server_utilization
-- (
--   server_id INT,
--   status_time TIMESTAMP,
--   session_status VARCHAR(10)
-- );

-- INSERT INTO server_utilization VALUES(1, '2022-08-02 10:00:00', 'start');
-- INSERT INTO server_utilization VALUES(1, '2022-08-04 10:00:00', 'stop');
-- INSERT INTO server_utilization VALUES(2, '2022-08-17 10:00:00', 'start');
-- INSERT INTO server_utilization VALUES(2, '2022-08-24 10:00:00', 'stop');

-- select * from server_utilization;

-- with temp as (select *, lag(status_time,1) OVER(partition by server_id ORDER BY status_time) as new_status_time from server_utilization)
-- SELECT sum(TIMESTAMPDIFF(day, t.new_status_time,t.status_time)) as total_uptime_days from temp t;

# Q86.


-- CREATE TABLE transactions
-- (
--   transaction_id INT,
--   merchant_id INT,
--   credit_card_id INT,
--   amount INT,
--   transaction_timestamp TIMESTAMP
-- );

-- INSERT INTO transactions VALUES(1, 101, 1, 100, '2022-09-25 12:00:00');
-- INSERT INTO transactions VALUES(2, 101, 1, 100, '2022-09-25 12:08:00');
-- INSERT INTO transactions VALUES(3, 101, 1, 100, '2022-09-25 12:28:00');
-- INSERT INTO transactions VALUES(4, 102, 2, 300, '2022-09-25 12:00:00');
-- INSERT INTO transactions VALUES(5, 102, 2, 400, '2022-09-25 14:00:00');

-- SELECT * from transactions;

-- -- Approach 1 

-- select *, lag(transaction_timestamp,1) over(PARTITION BY credit_card_id ) as new_col,
-- row_number() over(PARTITION BY credit_card_id order by amount) AS serial_number,
-- rank() over(PARTITION BY credit_card_id order by amount) AS serial_rank,
-- dense_rank() over(PARTITION BY credit_card_id order by amount) AS dense_number
-- from transactions;

-- with temp as (
-- 	select *, lag(transaction_timestamp,1) over(PARTITION BY credit_card_id ) as new_col
-- 	from transactions
-- ),
-- temp1 as (
-- 	select *,TIMESTAMPDIFF(minute,t.new_col, t.transaction_timestamp) as minute_diff from temp t
-- )
-- Select count(a.credit_card_id) as payment_count from temp1 a where a.minute_diff <= 10;

-- Approach 2 
-- WITH trx_with_repeadted AS
-- (
--   SELECT 
--     credit_card_id,
--     amount,
--     transaction_timestamp,
--     count(*) OVER(
--         PARTITION BY credit_card_id,amount
--         ORDER BY transaction_timestamp
--         RANGE BETWEEN INTERVAL '10' MINUTE PRECEDING AND CURRENT ROW
--     ) AS moving_count
--   FROM 
--     transactions
-- )
-- SELECT 
--   COUNT(*) as payment_count
-- FROM trx_with_repeadted
-- WHERE 
--   moving_count > 1
-- ;


# Q87.
-- CREATE TABLE orders
-- (
--   order_id INT,
--   customer_id INT,
--   trip_id INT,
--   status VARCHAR(30),
--   order_timestamp TIMESTAMP
-- );

-- CREATE TABLE trips
-- (
--   dasher_id INT,
--   trip_id INT,
--   estimated_delivery_timestamp TIMESTAMP,
--   actual_delivery_timestamp TIMESTAMP
-- );

-- CREATE TABLE customers
-- (
--   customer_id INT,
--   signup_timestamp TIMESTAMP
-- );

-- INSERT INTO orders VALUES(727424,8472, 100463, 'completed successfully', '2022-06-05 09:12:00');
-- INSERT INTO orders VALUES(242513, 2341, 100482, 'completed incorrectly', '2022-06-05 14:40:00');
-- INSERT INTO orders VALUES(141367, 1314, 100362, 'completed incorrectly', '2022-06-07 15:03:00');
-- INSERT INTO orders VALUES(582193, 5421, 100657, 'never_received', '2022-07-07 15:22:00');
-- INSERT INTO orders VALUES(253613, 1314, 100213, 'completed successfully', '2022-06-12 13:43:00');

-- INSERT INTO trips VALUES(101, 100463, '2022-06-05 09:42:00', '2022-06-05 09:38:00');
-- INSERT INTO trips VALUES(102, 100482, '2022-06-05 15:10:00', '2022-06-05 15:46:00');
-- INSERT INTO trips VALUES(101, 100362, '2022-06-07 15:33:00', '2022-06-07 16:45:00');
-- INSERT INTO trips VALUES(102, 100657, '2022-07-07 15:52:00',null);
-- INSERT INTO trips VALUES(103, 100213, '2022-06-12 14:13:00', '2022-06-12 14:10:00');

-- INSERT INTO customers VALUES(8472, '2022-05-30 00:00:00');
-- INSERT INTO customers VALUES(2341, '2022-06-01 00:00:00');
-- INSERT INTO customers VALUES(1314, '2022-06-03 00:00:00');
-- INSERT INTO customers VALUES(1435, '2022-06-05 00:00:00');
-- INSERT INTO customers VALUES(5421, '2022-06-07 00:00:00');

-- Select * from orders;
-- Select * from customers;
-- Select * from trips;

-- select o.*,c.*, MONTH(c.signup_timestamp) as mon from customers c join orders o
-- on o.customer_id = c.customer_id
-- where MONTH(c.signup_timestamp) = 6 and TIMESTAMPDIFF(day,c.signup_timestamp, o.order_timestamp) <=14 ;


-- with cte as (

-- select o.*, MONTH(c.signup_timestamp) as mon from customers c join orders o
-- on o.customer_id = c.customer_id
-- where MONTH(c.signup_timestamp) = 6 and TIMESTAMPDIFF(day,c.signup_timestamp, o.order_timestamp) <=14

-- )

-- SELECT * FROM CTE c inner join trips t 
-- on c.trip_id = t.trip_id;
# Q88.


-- CREATE TABLE scores
-- (
--   player_name VARCHAR(25),
--   gender VARCHAR(1),
--   day DATE,
--   score_points INT,
--   CONSTRAINT pk_scores PRIMARY KEY (gender, day)
-- );

-- INSERT INTO scores VALUES('Aron', 'F', '2020-01-01', 17);
-- INSERT INTO scores VALUES('Alice', 'F', '2020-01-07', 23);
-- INSERT INTO scores VALUES('Bajrang', 'M', '2020-01-07', 7);
-- INSERT INTO scores VALUES('Khali' , 'M', '2019-12-25', 11);
-- INSERT INTO scores VALUES('Slaman', 'M', '2019-12-30', 13);
-- INSERT INTO scores VALUES('Joe', 'M', '2019-12-31', 3);
-- INSERT INTO scores VALUES('Jose', 'M', '2019-12-18', 2);
-- INSERT INTO scores VALUES('Priya', 'F', '2019-12-31', 23);
-- INSERT INTO scores VALUES('Priyanka', 'F', '2019-12-30', 17);

-- select gender, day, sum(score_points) over(PARTITION BY gender ORDER BY day) from Scores

# Q89.

-- create table if not exists Person
-- (
--     id int,
--     name VARCHAR(50),
--     phone_number VARCHAR(50),
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Person VALUES (3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),(1,'Moncef','212-1234567'),(2,'Maroua','212-6523651'),(7,'Meir','972-1234567'),(9,'Rachel','972-0011100');

-- select * from Person;


-- create table if not exists Country
-- (
--     name VARCHAR(50),
--     country_code VARCHAR(50),
--     constraint pk PRIMARY KEY (country_code)
-- );

-- insert into Country VALUES ('Peru',51),('Israel',972),('Morocco',212),('Germany',49),('Ethiopia',251);

-- select * from Country;

-- create table if not exists Calls
-- (
--     caller_id int,
--     callee_id int,
--     duration int
-- );

-- insert into Calls VALUES (1,9,33),(2,9,4),(1,2,59),(3,12,102),(3,12,330),(12,3,5),(7,9,13),(7,1,3),(9,7,1),(1,7,7);

-- select * from Calls;

-- with country_phone as (SELECT p.*, c.name as country_name FROM person p JOIN
-- (SELECT name, 
-- CASE
--     WHEN LENGTH(country_code) < 3 then CONCAT("0", country_code)
--     else country_code
-- end as new_code
-- FROM country) as c 
-- ON
--     left(p.phone_number, 3) = c.new_code
-- )

-- SELECT country_name, sum(total_dur)/sum(total_count) as final FROM 
-- (SELECT cp.country_name, (2 * cal.duration) as total_dur,  (2 * count(cp.country_name)) as total_count FROM calls as cal
-- JOIN
--     country_phone as cp
-- ON
--     cal.caller_id = cp.id
-- GROUP BY cp.country_name, duration) as tmp
-- GROUP BY country_name ORDER BY final DESC LIMIT 1

# Q90.
-- CREATE TABLE numbers
-- (
--   num INT,
--   frequency INT
-- );

-- INSERT INTO numbers VALUES(0, 7);
-- INSERT INTO numbers VALUES(1, 1);
-- INSERT INTO numbers VALUES(2, 3);
-- INSERT INTO numbers VALUES(3, 1);

-- SELECT * FROM numbers;


# Q91.

-- CREATE TABLE employee
-- (
--   employee_id INT,
--   department_id INT,
--   CONSTRAINT pk_employee PRIMARY KEY(employee_id)
-- );

-- CREATE TABLE salary
-- (
--   id INT,
--   employee_id INT,
--   amount INT,
--   pay_date DATE,
--   CONSTRAINT pk_salary PRIMARY KEY(id),
--   CONSTRAINT fk_employee FOREIGN KEY(employee_id)
--     REFERENCES employee(employee_id)
-- );

-- INSERT INTO employee VALUES(1, 1);
-- INSERT INTO employee VALUES(2, 2);
-- INSERT INTO employee VALUES(3, 2);

-- INSERT INTO salary VALUES(1, 1, 9000, '2017-03-31');
-- INSERT INTO salary VALUES(2, 2, 6000, '2017-03-31');
-- INSERT INTO salary VALUES(3, 3, 10000, '2017-03-31');
-- INSERT INTO salary VALUES(4, 1, 7000, '2017-02-28');
-- INSERT INTO salary VALUES(5, 2, 6000, '2017-02-28');
-- INSERT INTO salary VALUES(6, 3, 8000, '2017-02-28');


-- SELECT * FROM employee;
-- SELECT * FROM salary;

-- -- Approach 1
-- with temp as (

-- 	SELECT e.department_id,s.amount, s.pay_date,
-- 	round(AVG(amount) OVER(PARTITION BY pay_date ),2) AS mon_avg
-- 	FROM salary s inner join employee e
-- 	on e.employee_id = s.employee_id
-- ),
-- temp2 as (
-- 	SELECT t.pay_date,t.department_id, AVG(t.amount) as dep_amount
-- 	FROM temp t
-- 	GROUP BY t.pay_date,t.department_id
-- ),
-- temp3 AS (
-- SELECT distinct DATE_FORMAT(a.pay_date, '%Y-%m') AS pay_month,a.department_id,
-- 	CASE WHEN a.mon_avg >  b.dep_amount then 'Higher'
-- 	WHEN a.mon_avg <  b.dep_amount then 'Lower'
--     else 'same' end as comparison
-- FROM temp a inner join temp2 b
-- ON a. pay_date = b.pay_date
-- ORDER BY a.department_id 
-- )
-- SELECT DISTINCT c.pay_month, c.department_id,c.comparison
-- from temp3 c

-- -- Approach 2

-- WITH department_company_avg_monthly AS(
--   SELECT
--     DISTINCT DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
--     department_id,
--     AVG(amount) OVER(PARTITION BY DATE_FORMAT(s.pay_date, '%Y-%m')) as company_avg,
--     AVG(amount) OVER(PARTITION BY DATE_FORMAT(s.pay_date, '%Y-%m'), department_id) as department_avg
--   FROM
--     salary s
--     JOIN employee e ON s.employee_id = e.employee_id
-- )
-- SELECT
--   pay_month,
--   department_id,
--   CASE
--     WHEN department_avg > company_avg
--       THEN 'higher'
--     WHEN department_avg < company_avg
--       THEN 'lower'
--     ELSE
--       'same'
--   END AS comparison
-- FROM
--   department_company_avg_monthly
-- ORDER BY
--   department_id
-- ;


# Q92.
-- CREATE TABLE activity
-- (
--   player_id INT,
--   device_id INT,
--   event_date DATE,
--   games_played INT,
--   CONSTRAINT pk_activity PRIMARY KEY(player_id, event_date)
-- );

-- INSERT INTO activity VALUES(1, 2, '2016-03-01', 5);
-- INSERT INTO activity VALUES(1, 2, '2016-03-02', 6);
-- INSERT INTO activity VALUES(2, 3, '2017-06-25', 1);
-- INSERT INTO activity VALUES(3, 1, '2016-03-01', 0);
-- INSERT INTO activity VALUES(3, 4, '2016-07-03', 5);


-- SELECT * FROM activity;

-- select a1.event_date as install_dt, count(a1.player_id) as installs, 
-- round(count(a3.player_id) / count(a1.player_id), 2) as Day1_retention
-- from Activity a1 left join Activity a2
-- on a1.player_id = a2.player_id and a1.event_date > a2.event_date
-- left join Activity a3
-- on a1.player_id = a3.player_id and datediff(a3.event_date, a1.event_date) = 1
-- where a2.event_date is null
-- group by a1.event_date;

# Q93.

-- CREATE TABLE players
-- (
--   player_id INT,
--   group_id INT,
--   CONSTRAINT pk_players PRIMARY KEY(player_id)
-- );

-- CREATE TABLE matches
-- (
--   match_id INT,
--   first_player INT,
--   second_player INT,
--   first_score INT,
--   second_score INT,
--   CONSTRAINT pk_matches PRIMARY KEY(match_id)
-- );

-- INSERT INTO players VALUES(15, 1);
-- INSERT INTO players VALUES(25, 1);
-- INSERT INTO players VALUES(30, 1);
-- INSERT INTO players VALUES(45, 1);
-- INSERT INTO players VALUES(10, 2);
-- INSERT INTO players VALUES(35, 2);
-- INSERT INTO players VALUES(50, 2);
-- INSERT INTO players VALUES(20, 3);
-- INSERT INTO players VALUES(40, 3);

-- INSERT INTO matches VALUES(1, 15, 45, 3, 0);
-- INSERT INTO matches VALUES(2, 30, 25, 1, 2);
-- INSERT INTO matches VALUES(3, 30, 15, 2, 0);
-- INSERT INTO matches VALUES(4, 40, 20, 5, 2);
-- INSERT INTO matches VALUES(5, 35, 50, 1, 1);

-- SELECT * FROM players;
-- SELECT * FROM matches;


-- WITH TEMP AS (
-- SELECT *, 
-- CASE WHEN first_score > second_score THEN first_player
-- 	 WHEN first_score < second_score THEN second_player
-- 	 WHEN first_score = second_score THEN IF(first_player < second_player,first_player,second_player )
--      END AS player_id
-- FROM matches),
-- temp2 as (
-- Select DISTINCT p.group_id , t.player_id,
-- ROW_NUMBER() over(PARTITION BY p.group_id order by t.player_id) as ranking
-- from players p inner join TEMP t
-- ON p.player_id = t.player_id
-- )
-- SELECT a.group_id, a.player_id FROM temp2 a
-- where a.ranking = 1

# Q94.
-- create table if not exists Student
-- (
--     student_id int,
--     student_name VARCHAR(50),
--     constraint pk PRIMARY KEY (student_id)
-- );


-- insert into Student VALUES (1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

-- select * from Student;


-- create table if not exists Exam
-- (
--     exam_id int,
--     student_id int,
--     score int,
--     constraint pk PRIMARY KEY (exam_id, student_id)
-- );

-- insert into Exam VALUES (10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60),(40,2,70),(40,4,80);

-- select * from Exam;

-- SELECT s.* FROM Exam e 
-- Inner join Student s
-- ON s.student_id = e.student_id
-- group by student_id 
-- having max(score) not in (select max(score) from Exam) 
--    and min(score) not in (select min(score) from Exam);

# Q95. 

-- create table if not exists Student
-- (
--     student_id int,
--     student_name VARCHAR(50),
--     constraint pk PRIMARY KEY (student_id)
-- );


-- insert into Student VALUES (1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

-- select * from Student;


-- create table if not exists Exam
-- (
--     exam_id int,
--     student_id int,
--     score int,
--     constraint pk PRIMARY KEY (exam_id, student_id)
-- );

-- insert into Exam VALUES (10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60),(40,2,70),(40,4,80);

-- select * from Exam;

-- SELECT s.* FROM Exam e 
-- Inner join Student s
-- ON s.student_id = e.student_id
-- group by student_id 
-- having max(score) not in (select max(score) from Exam) 
--    and min(score) not in (select min(score) from Exam);

# Q96.

-- CREATE TABLE songs_history
-- (
--   history_id INT,
--   user_id INT,
--   song_id INT,
--   song_plays INT
-- );

-- CREATE TABLE songs_weekly
-- (
--   user_id INT,
--   song_id INT,
--   listen_time TIMESTAMP
-- );

-- INSERT INTO songs_history VALUES(10011, 777, 1238, 11);
-- INSERT INTO songs_history VALUES(12452, 695, 4520, 1);

-- INSERT INTO songs_weekly VALUES(777, 1238, '2022-08-01 12:00:00');
-- INSERT INTO songs_weekly VALUES(695, 4520, '2022-08-04 08:00:00');
-- INSERT INTO songs_weekly VALUES(125, 9630, '2022-08-04 16:00:00');
-- INSERT INTO songs_weekly VALUES(695, 9852, '2022-08-07 12:00:00');

-- SELECT * FROM songs_history;
-- SELECT * FROM songs_weekly;

-- WITH temp as (
-- SELECT user_id,
-- 	   song_id,
--        song_plays
-- FROM   songs_history    
-- UNION ALL 
-- SELECT user_id,
-- 	   song_id,
--        COUNT(*) AS song_plays
-- FROM   songs_weekly
-- WHERE listen_time  <= '2022-08-04 16:00:00'
-- GROUP BY user_id, song_id
-- )
-- Select distinct user_id,  song_id,
-- sum(song_plays)   over(PARTITION BY user_id,song_id) as   song_plays
-- from temp
-- order by song_plays desc

# Q97.
-- CREATE TABLE emails
-- (
--   email_id INT,
--   user_id INT,
--   signup_date TIMESTAMP
-- );

-- CREATE TABLE texts
-- (
--   text_id INT,
--   email_id INT,
--   signup_action VARCHAR(20)
-- );

-- INSERT INTO emails VALUES(125, 7771, STR_TO_DATE('06/14/2022 00:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO emails VALUES(236, 6950, STR_TO_DATE('07/01/2022 00:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO emails VALUES(433, 1052, STR_TO_DATE('07/09/2022 00:00:00', '%m/%d/%Y %H:%i:%s'));

-- INSERT INTO texts VALUES(6878, 125, 'Confirmed');
-- INSERT INTO texts VALUES(6920, 236, 'Not Confirmed');
-- INSERT INTO texts VALUES(6994, 236, 'Confirmed');

-- select * from texts;
-- select * from emails;

-- with temp as (
-- select e.email_id,
-- CASE WHEN signup_action = 'Confirmed' THEN 1
-- END AS confirmed_users 
-- FROM emails e left join texts t 
-- ON e.email_id = t.email_id
-- AND t.signup_action = 'Confirmed'
-- )
-- SELECT round(SUM(confirmed_users)/COUNT(email_id),2) AS confirm_rate 
-- from temp

# Q98.
-- CREATE TABLE tweets
-- (
--   tweet_id INT,
--   user_id INT,
--   tweet_date TIMESTAMP
-- );


-- INSERT INTO tweets VALUES(214252, 111, STR_TO_DATE('06/01/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO tweets VALUES(739252, 111, STR_TO_DATE('06/01/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO tweets VALUES(846402, 111, STR_TO_DATE('06/02/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO tweets VALUES(241425, 254, STR_TO_DATE('06/02/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO tweets VALUES(137374, 111, STR_TO_DATE('06/04/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));


-- WITH tweet_per_day_by_user AS
-- (
--   SELECT
--     user_id,
--     tweet_date,
--     COUNT(*) as tweet_count
--   FROM 
--     tweets
--   group by 
--     user_id,
--     tweet_date
-- )
-- SELECT 
--   user_id,
--   tweet_date,
--   ROUND(
--     AVG(tweet_count) OVER( PARTITION BY user_id ORDER BY tweet_date
--       ROWS BETWEEN 2 PRECEDING and CURRENT ROW )
--   ,2) as rolling_avg_3d
-- FROM tweet_per_day_by_user;


#Q99:

-- CREATE TABLE activities
-- (
--   activity_id INT,
--   user_id INT,
--   activity_type VARCHAR(10),
--   time_spent DECIMAL(5,2),
--   activity_date TIMESTAMP
-- );

-- CREATE TABLE age_breakdown
-- (
--   user_id INT,
--   age_bucket VARCHAR(10)
-- );

-- INSERT INTO activities VALUES(7274, 123, 'open', 4.50, STR_TO_DATE('06/22/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO activities VALUES(2425, 123, 'send', 3.50, STR_TO_DATE('06/22/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO activities VALUES(1413, 456, 'send', 5.67, STR_TO_DATE('06/23/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO activities VALUES(1414, 789, 'chat', 11.00, STR_TO_DATE('06/25/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));
-- INSERT INTO activities VALUES(2536, 456, 'open', 3.00, STR_TO_DATE('06/25/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));

-- INSERT INTO age_breakdown VALUES(123, '31-35');
-- INSERT INTO age_breakdown VALUES(456, '26-30');
-- INSERT INTO age_breakdown VALUES(789, '21-25');

-- SELECT 
--   ab.age_bucket,
--   ROUND(
--     sum(
--       CASE
--         WHEN a.activity_type = 'send'
--           THEN
--             a.time_spent
--       END
--     )*100.0/sum(
--       CASE
--         WHEN a.activity_type in ('open','send')
--           THEN
--             a.time_spent
--       END
--     )
--   ,2) AS send_perc,
--   ROUND(
--     sum(
--       CASE
--         WHEN a.activity_type = 'open'
--           THEN
--             a.time_spent
--       END
--     )*100.0/sum(
--       CASE
--         WHEN a.activity_type in ('open','send')
--           THEN
--             a.time_spent
--       END
--     )
--   ,2) AS open_perc
-- FROM 
--   activities a
--   JOIN age_breakdown ab ON a.user_id = ab.user_id
-- WHERE
--   a.activity_type in ('open','send')
-- GROUP BY
--   ab.age_bucket
-- ;

#Q100:

-- CREATE TABLE personal_profiles
-- (
--   profile_id INT,
--   name VARCHAR(30),
--   followers INT
-- );

-- CREATE TABLE employee_company
-- (
--   personal_profile_id INT,
--   company_id INT
-- );

-- CREATE TABLE company_pages
-- (
--   company_id INT,
--   name VARCHAR(30),
--   followers INT
-- );

-- INSERT INTO personal_profiles VALUES(1, 'Nick Singh', 92000);
-- INSERT INTO personal_profiles VALUES(2, 'Zach Wilson', 199000);
-- INSERT INTO personal_profiles VALUES(3, 'Daliana Liu', 171000);
-- INSERT INTO personal_profiles VALUES(4, 'Ravit Jain', 107000);
-- INSERT INTO personal_profiles VALUES(5, 'Vin Vashishta', 139000);
-- INSERT INTO personal_profiles VALUES(6, 'Susan Wojcicki', 39000);

-- INSERT INTO employee_company VALUES(1, 4);
-- INSERT INTO employee_company VALUES(1, 9);
-- INSERT INTO employee_company VALUES(2, 2);
-- INSERT INTO employee_company VALUES(3, 1);
-- INSERT INTO employee_company VALUES(4, 3);
-- INSERT INTO employee_company VALUES(5, 6);
-- INSERT INTO employee_company VALUES(6, 5);

-- INSERT INTO company_pages VALUES(1 , 'The Data Science Podcast', 8000);
-- INSERT INTO company_pages VALUES(2, 'Airbnb', 700000);
-- INSERT INTO company_pages VALUES(3, 'The Ravit Show', 6000);
-- INSERT INTO company_pages VALUES(4, 'DataLemur', 200);
-- INSERT INTO company_pages VALUES(5, 'YouTube', 16000000);
-- INSERT INTO company_pages VALUES(6, 'DataScience.Vin', 4500);
-- INSERT INTO company_pages VALUES(9, 'Ace The Data Science Interview', 4479);

-- WITH profile_with_max_company_follower AS(
--   SELECT
--     pp.profile_id,
--     pp.name,
--     pp.followers,
--     cp.name AS company_name,
--     cp.followers AS company_follower,
--     max(cp.followers) OVER(PARTITION BY pp.profile_id) as max_company_follower
--   FROM 
--     personal_profiles pp
--     JOIN employee_company ec ON pp.profile_id = ec.personal_profile_id
--     JOIN company_pages cp ON cp.company_id = ec.company_id
--   ORDER BY 
--     pp.name
-- )
-- SELECT
--   DISTINCT profile_id
-- FROM 
--   profile_with_max_company_follower
-- WHERE 
--   followers > max_company_follower
-- ORDER BY 
--   profile_id
-- ;



















