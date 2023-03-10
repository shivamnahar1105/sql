# Ques-1
-- select * from city where countrycode = 'USA' AND population > 100000

# Ques-2
-- select * from city where countrycode = 'USA' AND population > 120000

# Ques-3
-- select * from city

# Ques-4
-- SELECT * FROM city where id=1661

# Ques-5
-- select * from city where countrycode = 'JPN'

# Ques-6
-- select district from city where countrycode = 'JPN'

# Ques-7
-- select city, state from station

# Ques-8
-- select distinct(id) , city from station

# Ques-9
-- select (count(city) - count(distinct(city))) as diff from station
--  
# Ques-10
# Max length of city
-- select city, length(city)  from station
-- group by city
-- order by length(city) desc, city
-- limit 1
# Min length of city
-- select city, length(city)  from station
-- group by city
-- order by length(city), city
-- limit 1

# Ques-11
-- select distinct city from station
-- WHERE LEFT(city , 1) IN ('a','e','i','o','u','A','E','I','O','U')
# Method-2
-- SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR 
-- CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%';

# Ques-12
-- select distinct city from station
-- WHERE RIGHT(city,1) IN  ('a','e','i','o','u','A','E','I','O','U')

# Ques -13
-- select distinct city from station
-- WHERE LEFT(city , 1) NOT IN ('a','e','i','o','u','A','E','I','O','U')

# Ques -14
-- select distinct city from station
-- WHERE RIGHT(city,1) NOT IN  ('a','e','i','o','u','A','E','I','O','U')

#Ques-15
-- select distinct(city) from station
-- WHERE RIGHT(city,1) NOT IN  ('a','e','i','o','u','A','E','I','O','U')
-- OR LEFT(city , 1) NOT IN ('a','e','i','o','u','A','E','I','O','U')

#Ques-16
-- select distinct(city) from station
-- WHERE RIGHT(city,1) NOT IN  ('a','e','i','o','u')
-- AND LEFT(city , 1) NOT IN ('a','e','i','o','u')

# Ques-17
-- create table if not exists product(
-- 	product_id int PRIMARY KEY,
--     product_name varchar(50),
--     unit_price int    
-- );

-- create table sales(
-- 	seller_id int,
--     product_id  int,
--     buyer_id int,
--     sale_date date,
--     quanity int, 
--     price int,
--     CONSTRAINT fk foreign key (product_id) references product(product_id)
-- );

-- INSERT INTO PRODUCT(product_id,product_name,unit_price)
-- values 
-- (1,'S8',1000),
-- (2,'G4',800),
-- (3,'iPhone',1400);

-- INSERT INTO SALES VALUES (1,1,1,'2019-01-21',2,2000);
-- INSERT INTO SALES VALUES (1,2,2,'2019-02-17',1,800);
-- INSERT INTO SALES VALUES (2,2,3,'2019-06-02',1,800);
-- INSERT INTO SALES VALUES (3,3,4,'2019-05-13',2,2800);


-- select product_id, product_name from product 
-- where product_id not in (select product_id from sales where sale_date not between '2019-01-01' and '2019-03-31')

# Q18.
-- create table if not exists views(

-- 	article_id int,
--     author_id int,
--     viewer_id int,
--     view_date date
-- );
-- insert into views(article_id,author_id,viewer_id,view_date)
-- values
-- (1,3,5,'2019-08-01'),
-- (1,3,6,'2019-08-02'),
-- (2,7,7,'2019-08-01'),
-- (2,7,6,'2019-08-02'),
-- (4,7,1,'2019-07-22'),
-- (3,4,4,'2019-07-21'),
-- (3,4,4,'2019-07-21');

-- select * from views;

-- select distinct author_id as id from views where author_id = viewer_id
-- order by author_id asc;

# Q19.

-- create table if not exists delivery (
-- 	delivery_id int,
--     customer_id int,
--     order_date date,
--     customer_pref_delivery_date date
-- );

#drop table delivery;
-- INSERT INTO delivery values(1,1,'2019-08-01','2019-08-02');
-- INSERT INTO delivery values(2,5,'2019-08-02','2019-08-02');
-- INSERT INTO delivery values(3,1,'2019-08-11','2019-08-11');
-- INSERT INTO delivery values(4,3,'2019-08-24','2019-08-26');
-- INSERT INTO delivery values(5,4,'2019-08-21','2019-08-22');
-- INSERT INTO delivery values(6,2,'2019-08-11','2019-08-13');

-- select * from delivery;

-- select round(sum
-- (case when order_date = customer_pref_delivery_date then 1 else 0 end)*100/count(distinct delivery_id),2 )
-- as immediate_percentage
-- from delivery ;

# Q20.
-- create table if not exists ads (
-- ad_id int,
-- user_id int,
-- action enum ('Clicked', 'Viewed', 'Ignored'),
-- Constraint pk primary key (ad_id,user_id)
-- );

-- INSERT INTO ads values(1,1,'Clicked');
-- INSERT INTO ads values(2,2,'Clicked');
-- INSERT INTO ads values(3,3,'Viewed');
-- INSERT INTO ads values(5,5,'Ignored');
-- INSERT INTO ads values(1,7,'Ignored');
-- INSERT INTO ads values(2,7,'Viewed');
-- INSERT INTO ads values(3,5,'Clicked');
-- INSERT INTO ads values(1,4,'Viewed');
-- INSERT INTO ads values(2,11,'Viewed');
-- INSERT INTO ads values(1,2,'Clicked');


-- select * from ads;

-- select ad_id,
-- case when ((num_of_clicks * 100)/ (num_of_clicks + num_of_views) ) is NULL then 0
-- 	 else round ( ((num_of_clicks * 100)/ (num_of_clicks + num_of_views)), 2 )
--      end as ctr
-- from 
-- (select ad_id, 
-- COUNT(CASE WHEN action = 'Clicked' then ad_id end) as num_of_clicks, 
-- COUNT(CASE WHEN action = 'Viewed' then ad_id end) as num_of_views 
-- from ads group by ad_id) tbl order by ctr desc ;

# Q21.

-- CREATE TABLE IF NOT EXISTS employee (
-- 		employee_id int,
--         team_id int,
--         CONSTRAINT pk PRIMARY KEY (employee_id)
-- );


-- INSERT INTO employee VALUES 
-- (1,8),
-- (2,8),
-- (3,8),
-- (4,7),
-- (5,9),
-- (6,9);

-- select * from employee;

-- SELECT employee_id, count(employee_id) over (partition by team_id) as team_size from employee	order by employee_id;


-- select employee_id, team_size from (SELECT team_id, count( case when team_id = 8 then employee_id 
-- 							when team_id = 7 then employee_id 
--                             when team_id = 9 then employee_id
--                             else employee_id end ) team_size FROM employee GROUP BY team_id) tbl; -- 
						
 # Q22.
 
--  CREATE TABLE IF NOT EXISTS countries(
-- 	country_id int,
--     country_name VARCHAR(250)
--  );

--  CREATE TABLE IF NOT EXISTS weather(
-- 	country_id int,
--     weather_state int,
--     day DATE,
--     CONSTRAINT pk PRIMARY KEY(country_id,day)
--  );
--  
--  INSERT INTO countries VALUES
--  (2, 'USA'),
--  (3, 'Australia'),
--  (7, 'Peru'),
--  (5, 'China'),
--  (8, 'Morocco'),
--  (9, 'Spain');
--  
--  SELECT * FROM COUNTRIES;
--  
--   INSERT INTO weather VALUES
--   (2,15,'2019-11-01'),
--   (2,12,'2019-10-28'),
--   (2,12,'2019-10-27'),
--   (3,-2,'2019-11-10'),
--   (3,0,'2019-11-11'),
--   (3,3,'2019-11-12'),
--   (5,16,'2019-11-07'),
--   (5,18,'2019-11-09'),
--   (5,21,'2019-11-23'),
--   (7,25,'2019-11-28'),
--   (7,22,'2019-12-01'),
--   (7,20,'2019-12-02'),
--   (8,25,'2019-11-05'),
--   (8,27,'2019-11-15'),
--   (8,31,'2019-11-25'),
--   (9,7,'2019-10-23'),
--   (9,3,'2019-12-23');
--   
--   SELECT * FROM WEATHER;


-- select ft.country_name, 
-- (case when ft.avg_weather_state<= 15 then 'cold'
-- 	 when ft.avg_weather_state>= 25 then 'hot'
--      else 'warm' end ) as weather_type
--  from (select *, avg(tbl1.weather_state)  over(partition by tbl1.country_name) as avg_weather_state from 
-- (select * from (select w.*,c.country_name from countries c inner join weather w WHERE c.country_id = w.country_id) tbl 
-- WHERE MONTH(tbl.day) = 11 AND YEAR(tbl.day) = 2019) tbl1)ft group by ft.country_name, weather_type



# Q23.

-- create TABLE if not EXISTS prices(

-- product_id INT,
-- start_date DATE,
-- end_date DATE,
-- price INT,

-- CONSTRAINT pk PRIMARY KEY(product_id,start_date,end_date)

-- );


-- CREATE TABLE IF NOT EXISTS unitssold(

-- product_id INT,
-- purchase_date date,
-- units int
-- );

-- insert into prices values
-- (1,'2019-02-17','2019-02-28',5),
-- (1,'2019-03-01','2019-03-22',20),
-- (2,'2019-02-01','2019-02-20',15),
-- (2,'2019-02-21','2019-03-31',30);

-- select * from prices;

-- INSERT INTO unitssold Values
-- (1,'2019-02-25',100),
-- (1,'2019-03-01',15),
-- (2,'2019-02-10',200),
-- (2,'2019-03-22',3);

-- select * from unitssold;

-- select p.product_id, Round(SUM(u.units * p.price)/ SUM(u.units) , 2) as average_price
-- from prices p inner join unitssold u on p.product_id = u.product_id
-- where u.purchase_date between p.start_date and p.end_date 
-- group by p.product_id


# Q24.
-- CREATE Table if not exists activity(

-- player_id INT,
-- device_id INT,
-- event_date DATE,
-- games_played INT,

-- CONSTRAINT pk PRIMARY KEY (player_id,event_date)

-- );

-- INSERT INTO activity VALUES 
-- (1,2,'2016-03-01',5),
-- (1,2,'2016-05-02',6),
-- (2,3,'2017-06-25',1),
-- (3,1,'2016-03-02',0),
-- (3,4,'2018-07-03',5);

-- select * FROM activity;


-- SELECT player_id,first_login from
-- (select player_id, event_date as first_login, ROW_NUMBER() over(PARTITION BY player_id ORDER BY event_date) as rw_rank from activity) a 
-- where a.rw_rank = 1


# Q25.
-- SELECT player_id,device_id from
-- (select *, ROW_NUMBER() over(PARTITION BY player_id ORDER BY event_date) as rw_rank from activity) a 
-- where a.rw_rank = 1

# Q26.
-- CREATE Table if not exists products(

-- product_id INT,
-- product_name VARCHAR(250),
-- product_category VARCHAR(250),

-- CONSTRAINT pk PRIMARY KEY (product_id)

-- );

-- CREATE Table if not exists orders(

-- product_id INT,
-- order_date DATE,
-- unit INT,

-- CONSTRAINT pk FOREIGN KEY (product_id) REFERENCES products(product_id)

-- );

-- insert into products values (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),
-- (3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');
-- select * FROM products;

-- insert into orders values (1,'2020-02-05',60),(1,'2020-02-10',70),(2,'2020-01-18',30),
-- (2,'2020-02-11',80),(3,'2020-02-17',2),(3,'2020-02-24',3),(4,'2020-03-01',20),(4,'2020-03-04',30),
-- (4,'2020-03-04',60),(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

-- select * FROM orders;


-- select product_name, sum(unit) as unit
-- from orders o inner join products pr on pr.product_id = o.product_id 
-- where  MONTH(o.order_date)=02 AND YEAR(o.order_date)=2020
-- GROUP BY product_name
-- having sum(unit) >=100

# Q27.

-- CREATE Table IF NOT EXISTS users(
-- user_id INT,
-- name VARCHAR(250),
-- mail VARCHAR(450),

-- CONSTRAINT pk PRIMARY KEY (user_id)

-- );

-- insert into  users VALUES (1,'Winston','winston@leetcode.com'),
-- (2,'Jonathan','jonathanisgreat'),(3,'Annabelle','bella-@leetcode.com'),
-- (4,'Sally','sally.come@leetcode.com'),(5,'Marwan','quarz#2020@leetcode.com'),
-- (6,'David','david69@gmail.com'),(7,'Shapiro','.shapo@leetcode.com');

-- SELECT *
-- FROM users
-- WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');

# Q28.

-- create table if not exists Customers
-- (
--     customer_id int,
--     name varchar(50),
--     country varchar(50),
--     constraint pk PRIMARY KEY (customer_id)
-- );


-- insert into Customers VALUES (1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Moustafa','Egypt');

-- select * from Customers;


-- # Table: Product
-- create table if not exists products
-- (
--     product_id int,
--     description varchar(255),
--     price int,
--     constraint pk PRIMARY KEY (product_id)
-- );

-- insert into products values (10,'LC Phone',300),(20,'LC T-Shirt',10),(30,'LC Book',45),(40,'LC Keychain',2);

-- select * from products;

-- # Table: Orders
-- create table if not exists Orders
-- (
--     order_id int,
--     customer_id int,
--     product_id int,
--     order_date DATE,
--     quantity int,
--     constraint pk PRIMARY KEY (order_id)
--     -- constraint fk FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
--     -- constraint fk FOREIGN KEY (product_id) REFERENCES Product(product_id)
-- );

-- insert into Orders VALUES (1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),
-- (3,1,30,'2020-07-08',2),(4,2,10,'2020-06-15',2),(5,2,40,'2020-07-01',10),
-- (6,3,20,'2020-06-24',2),(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);

-- select o.customer_id, c.name
-- from Orders o , products p , Customers c 
-- where o.product_id = p.product_id and c.customer_id = o.customer_id
-- GROUP BY o.customer_id
-- HAVING
-- (
--     sum(case when o.order_date like '2020-06%' then o.quantity*p.price else 0 end) >= 100
--     and
--     sum(case when o.order_date like '2020-07%' then o.quantity*p.price else 0 end) >= 100
-- ); 


# Q29. 

-- create table if not exists tv_program
-- (
--     program_date date,
--     content_id int,
--     channel VARCHAR(250),
--     constraint pk PRIMARY KEY (program_date,content_id)
-- );

-- create table if not exists content
-- (
--     content_id VARCHAR(25),
--     title VARCHAR(250),
--     Kids_content ENUM('Y','N'),
--     content_type VARCHAR(250),
--     
--     constraint pk PRIMARY KEY (content_id)
-- );


-- insert into tv_program VALUES ('2020-06-10 08:00',1,'LC-Channel'),
-- ('2020-05-11 12:00',2,'LC-Channel'),('2020-05-12 12:00',3,'LC-Channel'),
-- ('2020-05-13 14:00',4,'Disney Ch'),('2020-06-18 14:00',4,'Disney Ch'),
-- ('2020-07-15 16:00',5,'Disney Ch');

-- SELECT * FROM tv_program;

-- insert into content VALUES (1,'Leetcode Movie','N','Movies'),(2,'Alg. for Kids','Y','Series'),
-- (3,'Database Sols','N','Series'),(4,'Aladdin','Y','Movies'),(5,'Cinderella','Y','Movies');

-- SELECT * FROM content;

-- SELECT title from content c inner join tv_program t
-- on c.content_id  = t.content_id
-- where program_date like '2020-06%' and Kids_content = 'Y'


# Q30.

-- CREATE TABLE IF NOT EXISTS NPV(
-- 	id INT,
--     year INT,
--     npv int,
--     
--     constraint pk primary key(id, year)
-- );

-- CREATE TABLE IF NOT EXISTS Queries(
-- 	id INT,
--     year INT,
--     
--     constraint pk primary key(id, year)
-- );

-- insert into NPV VALUES (1,2018,100),(7,2020,30),(13,2019,40),(1,2019,113),(2,2008,121),(3,2009,12),(11,2020,99),(7,2019,0);

-- SELECT * from NPV;

-- insert into Queries VALUES (1, 2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019);

-- SELECT * FROM Queries;

-- SELECT q.id, q.year,coalesce(n.NPV, 0) from  Queries q left join NPV n
-- on q.id = n.id and q.year=n.year;


# Q32.

-- CREATE table if not exists employees(
-- 	
--     id INT,
--     name VARCHAR(250),
--     
--     constraint pk primary key(id)
-- );

-- CREATE table if not exists employeeuni(
-- 	
--     id INT,
--     unique_id int,
--     
--     constraint pk primary key(id,unique_id)
-- );


-- insert into employees VALUES (1,'Alice'),(7,'Bob'),(11,'Meir'),(90,'Winston'),(3,'Jonathan');
-- SELECT * from employees;

-- insert into employeeuni VALUES (3,1),(11,2),(90,3);
-- select * from employeeuni;

-- select e.name, 
-- (case when e.id = u.id then u.unique_id end ) unique_id
-- from employees e left join employeeuni u
-- on e.id = u.id
-- order by u.unique_id

# Q33.
-- create TABLE if not exists users(
-- 	id INT,
--     name varchar(250),
--     
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into users VALUES (1,'Alice'),(2,'Bob'),(3,'Alex'),(4,'Donald'),(7,'Lee'),(13,'Jonathan'),(19,'Elvis');

-- select * from users;

-- create table if not exists rides
-- (
--     id int,
--     user_id int,
--     distance int,
--     constraint pk PRIMARY KEY (id),
--     constraint fok FOREIGN KEY (user_id) REFERENCES users(id)
-- );

-- insert into rides VALUES (1,1,120),(2,2,317),(3,3,222),(4,7,100),(5,13,312),(6,19,50),(7,7,120),(8,19,400),(9,7,230);


-- select name, coalesce(sum(distance),0) as travelled_distance 
-- from users u left join  rides r 
-- on r.user_id = u.id
-- GROUP BY name
-- ORDER BY travelled_distance desc, name ASC


# Q34.

-- create table if not exists Products
-- (
--     product_id int,
--     product_name varchar(50),
--     product_category VARCHAR(50),
--     constraint pk PRIMARY KEY (product_id)
-- );

-- insert into Products VALUES 
-- (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),
-- (3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');

-- select * from Products;


-- create table if not exists Orders
-- (
--     product_id int,
--     order_date date,
--     unit int,
--     CONSTRAINT foky FOREIGN KEY (product_id) REFERENCES Products(product_id)
-- );

-- insert into Orders values 
-- (1,'2020-02-05',60),(1,'2020-02-10',70),(2,'2020-01-18',30),
-- (2,'2020-02-11',80),(3,'2020-02-17',2),(3,'2020-02-24',3),
-- (4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
-- (5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

-- select * from Orders;


-- SELECT p.product_name, sum(o.unit)AS total_unit from Products p
-- left join Orders o 
-- ON p.product_id = o.product_id
-- where order_date BETWEEN '2020-02-01' and '2020-02-29'
-- GROUP BY product_name
-- HAVING sum(o.unit) >=100

# Q 35.

-- create table if not exists movies
-- (
--     movie_id int,
--     title varchar(50),
--     constraint pk PRIMARY KEY (movie_id)
-- );

-- insert into movies VALUES (1,'Avengers'),(2,'Frozen 2'),(3,'Joker');
-- select * from movies;


-- create table if not exists users
-- (
--     user_id int,
--     name varchar(50),
--     constraint pk PRIMARY KEY (user_id)
-- );

-- insert into users VALUES (1,'Daniel'),(2,'Monica'),(3,'Maria'),(4,'James');
-- select * from users;

-- create table if not exists movierating
-- (
--     movie_id int,
--     user_id int,
--     rating int,
--     created_at date,
--     constraint pk PRIMARY KEY (movie_id, user_id)
-- );

-- insert into movierating VALUES (1,1,3,'2020-01-12'),(1,2,4,'2020-02-11'),
-- (1,3,2,'2020-02-12'),(1,4,1,'2020-01-01'),(2,1,5,'2020-02-17'),(2,2,2,'2020-02-01'),
-- (2,3,2,'2020-03-01'),(3,1,3,'2020-02-22'),(3,2,4,'2020-02-25');
-- select * from movierating;


-- select name as results from ( 
-- select distinct u.name  from users u inner join movierating mr
-- on u.user_id = mr.user_id
-- group by u.name ORDER BY COUNT(u.name) desc, name asc LIMIT 1) first_query
-- union
-- select title as results from
-- (select title from movierating mr inner join movies m
-- on m.movie_id = mr.movie_id
-- where created_at between '2020-02-01' and '2020-02-28'
-- group by title ORDER BY avg(rating) desc, title asc limit 1) second_query;

# Q36.

-- create table if not exists Users
-- (
--     id int,
--     name varchar(50),
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Users VALUES (1,'Alice'),(2,'Bob'),(3,'Alex'),(4,'Donald'),(7,'Lee'),(13,'Jonathan'),(19,'Elvis');

-- select * from Users;



-- create table if not exists Rides
-- (
--     id int,
--     user_id int,
--     distance int,
--     constraint pk PRIMARY KEY (id),
--     constraint fkk1 FOREIGN KEY (user_id) REFERENCES Users(id)
-- );

-- insert into Rides VALUES (1,1,120),(2,2,317),(3,3,222),(4,7,100),(5,13,312),(6,19,50),(7,7,120),(8,19,400),(9,7,230);

-- select * from Rides;

-- SELECT DISTINCT(u.name),coalesce(sum(distance),0) as travelled_distance from  Users u left join Rides r 
-- on u.id = r.user_id
-- GROUP BY name
-- order by travelled_distance desc, name asc

# Q37.
-- create table if not exists Employees
-- (
--     id int,
--     name varchar(50),
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Employees VALUES (1,'Alice'),(7,'Bob'),(11,'Meir'),(90,'Winston'),(3,'Jonathan');

-- select * from Employees;


-- create table if not exists EmployeeUNI
-- (
--     id int,
--     unique_id int,
--     constraint pk PRIMARY KEY (id, unique_id)
-- );

-- insert into EmployeeUNI VALUES (3,1),(11,2),(90,3);
-- select * from EmployeeUNI;

-- select unique_id, name from Employees e LEFT JOIN EmployeeUNI eu
-- on e.id = eu.id
-- order by unique_id

# Q38.

-- create table if not exists Departments
-- (
--     id int,
--     name varchar(50),
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Departments VALUES (1,'Electrical Engineering'),(7,'Computer Engineering'),(13,'Business Administration');

-- select * from Departments;

-- create table if not exists Students
-- (
--     id int,
--     name varchar(50),
--     department_id int,
--     constraint pk PRIMARY KEY (id)
-- );

-- insert into Students VALUES (23,'Alice',1),(1,'Bob',7),(5,'Jennifer',13),(2,'John',14),(4,'Jasmine',77),(3,'Steve',74),(6,'Luis',1),(8,'Jonathan',7),(7,'Daiana',33),(11,'Madelynn',1);

-- select * from Students;

-- select id,name from Students 
-- WHERE department_id not in (select id from Departments ) 

# Q39.

-- create table if not exists calls
-- (
--     from_id int,
--     to_id int,
--     duration int
-- );

-- insert into calls VALUES (1,2,59),(2,1,11),(1,3,20),(3,4,100),(3,4,200),(3,4,200),(4,3,499);

-- select * from calls;

-- SELECT least(from_id,to_id) as person1, greatest(from_id,to_id) as person2, 
-- count(*) as call_count,
-- sum(duration) as total_duration
-- from calls
-- GROUP BY person1,person2


# Q40.

-- create table if not exists prices
-- (
--     product_id int,
--     start_date date,
--     end_date date,
--     price int,
--     constraint pk PRIMARY KEY (product_id, start_date, end_date)
-- );

-- insert into prices VALUES (1,'2019-02-17','2019-02-28',5), (1,'2019-03-01','2019-03-22',20), (2,'2019-02-01','2019-02-20',15), (2,'2019-02-21','2019-03-31',30);

-- select * from prices;

-- create table if not exists unitsold
-- (
--     product_id int,
--     purchase_date date,
--     units int
-- );

-- insert into unitsold VALUES (1,'2019-02-25',100),(1,'2019-03-01',15),(2,'2019-02-10',200),(2,'2019-03-22',30);

-- select * from unitsold;

-- SELECT DISTINCT u.product_id, round(sum(u.units*p.price)/sum(u.units),2) as average_price 
-- FROM unitsold u INNER JOIN prices p
-- on u.product_id = p.product_id
-- WHERE purchase_date between start_date and end_date
-- GROUP BY product_id

# Q41.

-- create table if not exists warehouse
-- (
--     name VARCHAR(50),
--     product_id int,
--     units int,
--     constraint pk PRIMARY KEY (name, product_id)
-- );

-- insert into warehouse VALUES ('LCHouse1',1,1),('LCHouse1',2,10),('LCHouse1',3,5),('LCHouse2',1,2),('LCHouse2',2,2),('LCHouse3',4,1);
-- select * from warehouse;


-- create table if not exists products
-- (
--     product_id int,
--     product_name VARCHAR(50),
--     Width int,
--     Length int,
--     Height int,
--     constraint pk PRIMARY KEY (product_id)
-- );

-- insert into products VALUES (1,'LC-TV',5,50,40),(2,'LC-KeyChain',5,5,5),(3,'LC-Phone',2,10,10),(4,'LC-T-Shirt',4,10,20);

-- select * from products;


-- -- Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.

-- SELECT w.name as warehouse_name, sum(p.width * p.length * p.height * w.units) as volume
-- from warehouse w inner join products p
-- on w.product_id = p.product_id
-- GROUP BY name;

# Q42.

-- create table if not exists Sales
-- (
--     sale_date date,
--     fruit enum("apples","oranges"),
--     sold_num int,
--     constraint pk PRIMARY KEY (sale_date, fruit)
-- );

-- insert into Sales VALUES ('2020-05-01','apples',10),('2020-05-01','oranges',8),('2020-05-02','apples',15),
-- ('2020-05-02','oranges',15),('2020-05-03','apples',20),('2020-05-03','oranges',0),('2020-05-04','apples',15),('2020-05-04','oranges',16);

-- select * from Sales;

-- # Approach 1
-- SELECT * from ( SELECT sale_date, ( lag(sold_num,1) over (PARTITION BY  sale_date) - sold_num ) as diff from Sales) temp
-- WHERE diff is not null 
-- order by sale_date;

-- # Approach 2 

-- select s.sale_date, (s.sold_num-ss.sold_num)as difference from Sales s 
-- inner join Sales ss
-- on s.sale_date = ss.sale_date
-- where s.fruit = 'apples' and ss.fruit = 'oranges'
-- order by sale_date

# Q43.
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

-- # Approach -1
-- with CTE AS (
-- SELECT player_id,min(event_date) as ed 
-- from Activity 
-- GROUP BY player_id)

-- SELECT round((count(distinct c.player_id) / (select count(distinct player_id) from Activity)),2)as fraction
-- from cte c inner join Activity a 
-- ON c.player_id = a.player_id
-- and datediff(c.ed, a.event_date) = -1;

-- # Approach -2 
-- WITH CTE AS (
-- SELECT
-- player_id, 
-- lead(event_date,1) over(PARTITION BY player_id order by event_date) - event_date as diff
-- from
-- Activity)

-- SELECT
-- round((count(distinct c.player_id) / (select count(distinct player_id) from Activity)),2)as fraction
-- FROM
-- CTE c
-- JOIN Activity a
-- on c.player_id = a.player_id
-- where c.diff = 1;

# Q44.

-- CREATE TABLE IF NOT EXISTS employee(
-- 	id INT,
--     name varchar(250),
--     department VARCHAR(10),
--     managerId INT,
--     PRIMARY KEY (id)
-- );

-- INSERT INTO employee Values 
-- (101,'John','A',NULL),
-- (102,'Dan','A',101),
-- (103,'James','A',101),
-- (104,'Amy','A',101),
-- (105,'Anne','A',101),
-- (106,'Ron','B',101);

-- SELECT * FROM employee;

-- SELECT name FROM employee
-- where id = ( SELECT managerId from employee
-- GROUP BY managerId
-- HAVING count(managerId)>=5
-- );


# Q45.
-- create table if not exists Department
-- (
--     dept_id int,
--     dept_name VARCHAR(50),
--     constraint pk PRIMARY KEY (dept_id)
-- );


-- insert into Department VALUES (1,'Engineering'),(2,'Science'),(3,'Law');

-- select * from Department;

-- create table if not exists Student
-- (
--     student_id int,
--     student_name VARCHAR(50),
--     gender VARCHAR(50),
--     dept_id int,
--     constraint pk PRIMARY KEY (student_id),
--     constraint fk FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
-- );

-- insert into Student VALUES (1,'Jack','M',1),(2,'Jane','F',1),(3,'Mark','M',2);

-- select * from Student;

-- select dept_name,coalesce(count(student_id),0) as student_numbers from Department d LEFT join Student s
-- on d.dept_id = s.dept_id
-- GROUP BY dept_name
-- order by student_numbers desc, d.dept_name asc;


# Q46.

-- create table if not exists Product
-- (
--     product_key int,
--     constraint pk PRIMARY KEY (product_key)
-- );

-- insert into Product VALUES (5),(6);

-- select * from Product;


-- create table if not exists Customer
-- (
--     customer_id int,
--     product_key int,
--     constraint fkc FOREIGN KEY (product_key) REFERENCES Product(product_key)
-- );


-- insert into Customer VALUES (1,5),(2,6),(3,5),(3,6),(1,6);

-- select * from Customer;

-- # Approach 1
-- Select tbl.customer_id from   (select customer_id,count(p.product_key) as total_count  from Customer c inner join Product p
-- on c.product_key = p.product_key
-- GROUP BY customer_id) tbl where tbl.total_count = 2;

-- #Approach 2
-- select customer_id  from Customer c inner join Product p
-- on c.product_key = p.product_key
-- GROUP BY customer_id
-- having count(p.product_key) = 2


# Q47.

 
-- create table if not exists Employee
-- (
--     employee_id int,
--     name VARCHAR(50),
--     experience_years int,
--     constraint pk PRIMARY KEY (employee_id)
-- );

-- insert into Employee VALUES (1,'Khaled',3),(2,'Ali',2),(3,'John',3),(4,'Doe',2);

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

-- SELECT
--     project_id,
--     employee_id
-- FROM (
--     SELECT
--         p.project_id,
--         p.employee_id,
--         DENSE_RANK() OVER(PARTITION BY p.project_id ORDER BY e.experience_years DESC) as rnk
--     FROM Project as p JOIN Employee as e
--     ON p.employee_id = e.employee_id
--     ) x
-- WHERE rnk = 1;

# Q48.
-- create table if not exists Books
-- (
--     book_id int,
--     name VARCHAR(50),
--     available_from date,
--     constraint pk PRIMARY KEY (book_id)
-- );

-- insert into Books VALUES (1,'"Kalila And Demna"','2010-01-01'),(2,'"28 Letters"','2012-05-12'),
-- (3,'"The Hobbit"','2019-06-10'),(4,'"13 Reasons Why"','2010-01-01'),(5,'"The Hunger Games"','2008-09-21');

-- select * from Books;

-- create table if not exists Orders
-- (
--     order_id int,
--     book_id int,
--     quantity int,
--     dispatch_date date,
--     constraint pk PRIMARY KEY (order_id),
--     constraint fko FOREIGN KEY (book_id) REFERENCES Books(book_id)
-- );

-- insert into Orders VALUES (1,1,2,'2018-07-26'),(2,1,1,'2018-11-05'),(3,3,8,'2019-06-11'),
-- (4,4,6,'2019-06-05'),(5,4,5,'2019-06-20'),(6,5,9,'2009-02-02'),(7,5,8,'2010-04-13');


-- select * from Orders;

-- SELECT b.book_id, name from books b left join orders o
-- on b.book_id = o.book_id
-- where available_from < '2019-05-23'
-- and dispatch_date between '2018-06-23' and '2019-06-23'
-- or dispatch_date is NULL
-- GROUP BY b.book_id, name
-- HAVING coalesce(sum(quantity),0) < 10

# Q49.
-- create table if not exists Enrollments
-- (
--     student_id int,
--     course_id int,
--     grade int,
--     constraint pk PRIMARY KEY (student_id, course_id)
-- );

-- insert into Enrollments VALUES (2,2,95),(2,3,95),(1,1,90),(1,2,99),(3,1,80),(3,2,75),(3,3,82);

-- select * from Enrollments;

-- SELECT  tbl.student_id, 
-- tbl.course_id, tbl.grade  
-- FROM   (SELECT *, ROW_NUMBER() over(PARTITION BY student_id ORDER BY grade desc) as rnk
-- from Enrollments) tbl
-- where tbl.rnk = 1

# Q50.

create table if not exists Players
(
    player_id int,
    group_id int,
    constraint pk PRIMARY KEY (player_id)
);

insert into Players VALUES (15,1), (25,1), (30,1), (45,1), (10,2), (35,2), (50,2), (20,3), (40,3);

select * from Players;

create table if not exists Matches
(
    match_id int,
    first_player int,
    second_player int,
    first_score int,
    second_score int,
    constraint pk PRIMARY KEY (match_id)
);

insert into Matches VALUES (1,15,45,3,0),(2,30,25,1,2),(3,30,15,2,0),(4,40,20,5,2),(5,35,50,1,1);

select * from Matches;
















