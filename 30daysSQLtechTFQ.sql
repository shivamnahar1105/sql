--- VIDEO_Q1 ---

/* Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    - if custom1 = custom3 and custom2 = custom4 : then keep only one pair

- For pairs of brands in the same year 
    - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs

- For brands that do not have pairs in the same year : keep those rows as well
*/

WITH cte as (
select *,
	case when brand1 < brand2 then concat(brand1, brand2, year)
		 else concat(brand2, brand1, year) end as pair_id 
from brands	
),
cte_rn as (
	SELECT *, row_number() over(partition by pair_id) as rn from cte 
)
select brand1, brand2, year,custom1,custom2, custom3, custom4  from cte_rn
where rn = 1 or (custom1 <> custom3 and custom2 <> custom4)

-----------------------------------------------------------------------------------
--- VIDEO_Q2 ---
-----------------------------------------------------------------------------------
--- VIDEO_Q3 ---
-- PROBLEM STATEMENT: Write a sql query to return the footer 
-- values from input table, meaning all 
-- the last non null values from each field as shown in expected output.
-- SELECT * FROM FOOTER order by id desc3
-- Solution 1:
select * from 
(
select car from footer where car is not null order by id desc limit 1) as car
cross join (
select length from footer where length is not null order by id desc limit 1) as length
cross join (
select width from footer where width is not null order by id desc limit 1) as width
cross join (
select height  from footer where height is not null order by id desc limit 1) as height

-- Solution 2:
with cte as (
select *,
	sum(case when car is not null then 1 else 0 end) over(order by id) AS car_seg,
	sum(case when length is not null then 1 else 0 end ) over(order by id) AS length_seg,
	sum(case when width is not null then 1 else 0 end) over(order by id) AS width_seg,
	sum(case when height is not null then 1 else 0 end) over(order by id)  AS height_seg
	from footer
)
select 
	first_value(car) over(partition by car_seg order by id),
	first_value(length) over(partition by length_seg order by id),
	first_value(width) over(partition by width_seg order by id),
	first_value(height) over(partition by height_seg order by id) 
from cte
order by id desc
limit 1
-----------------------------------------------------------------------------------
--- VIDEO_Q4 ---

/* Problem Statement:
segregate the values and give me two results:
1. with min id and non null name and location
2. with max id and non null name and location
*/
-- Approach 1:
select coalesce(min(id)) as id,
	   coalesce(min(name)) as name,
	   coalesce(min(location)) as location 
from q4_data

select coalesce(max(id)) as id,
	   coalesce(min(name)) as name,
	   coalesce(min(location)) as location 
from q4_data

-- Approach 2:

-- OUTPUT 1
select min(id) as id
, min(name) as name
, min(location) as location
from Q4_data;

-- OUTPUT 2
select max(id) as id
, min(name) as name
, min(location) as location
from Q4_data;
-----------------------------------------------------------------------------------
--- VIDEO_Q5 ---

/* Problem Statement:
Using the given Salary, Income and Deduction tables, 
first write an sql query to populate the Emp_Transaction 
table as shown below and then generate a salary report as shown.
*/
--  Create Table query:
/*
drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);


drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


drop table if exists emp_transaction;
create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount		numeric
);
insert into emp_transaction
select s.emp_id, s.emp_name, x.trans_type,
	x.percentage * s.base_salary/100
	from salary s
cross join
	(
		select id, income as trans_type, percentage from income
			union 
		select id, deduction as trans_type, percentage from deduction
) x 
order by x.trans_type
select * from salary;
select * from income;
select * from deduction;
select * from emp_transaction;
*/
select distinct emp_name, 
	sum(case when trns_type = 'Basic' then amount else 0 end) as basic,
	sum(case when trns_type = 'Allowance' then amount else 0 end) as allowance,
	sum(case when trns_type = 'Others' then amount else 0 end) as others,
	sum(case when trns_type IN ('Basic','Allowance','Others') then amount else 0 end) as gross,
	sum(case when trns_type = 'Health' then amount else 0 end) as health,
	sum(case when trns_type = 'House' then amount else 0 end) as house,
	sum(case when trns_type = 'Insurance' then amount else 0 end) as insurance,
	sum(case when trns_type IN ('Insurance','Health','House') then amount else 0 end) as total_deuctions,	
	sum(amount) - sum(case when trns_type = 'Insurance' then amount else 0 end) as net_pay
from emp_transaction
group by emp_name
order by emp_name

-- Approach 2 using Pivot/Crosstab

/* Cross Tab Basic information 
create extension if not exists tablefunc;

-- select * 
-- 	from crosstab('base query order by cols',
-- 					'list of columns')
-- 	as result (final columns with data type)
base query - basically gives all the data to transform row level data to column level data
			and it needs to return atleast three columns. We should always order the base query
			otherwise aggregation will not happen properly.
			first col - is usually a column i.e. unique identifier.
			second col - is a col whose value will make different new columns based 
						 on the value in the col.
			third col - is usually the values that will be return by each column.

list of columns:  It usually are the columns we want in o/p. They can be either hardcoded or
					we can select them using the select query.

*/	

	-- SOLUTION PostgreSQL
select employee
, basic, allowance, others
, (basic + allowance + others) as gross
, insurance, health, house 
, (insurance + health + house) as total_deductions
, (basic + allowance + others) - (insurance + health + house) as net_pay
from crosstab('select emp_name, trns_type, sum(amount) as amount
			   from emp_transaction
			   group by emp_name, trns_type
			   order by emp_name, trns_type'
			  ,'select distinct trns_type from emp_transaction order by trns_type')
	as result(employee varchar, Allowance numeric, basic numeric, health numeric
			 , house numeric, insurance numeric, others numeric)




-- SOLUTION Microsoft SQL Server (Similar works for Oracle too, just replace [] with "")
select Employee
, Basic, Allowance, Others
, (Basic + Allowance + Others) as Gross
, Insurance, Health, House
, (Insurance + Health + House) as Total_Deductions
, ((Basic + Allowance + Others) - (Insurance + Health + House)) as Net_Pay
from 
    (
        select t.emp_name as Employee, t.trns_type, t.amount
        from emp_transaction t
        
    ) b
pivot 
    (
        sum(amount)
        for trns_type in ([Allowance],[Basic],[Health],[House],[Insurance],[Others])
    ) p;

	

-----------------------------------------------------------------------------------
--- VIDEO_Q6 ---

/* Problem Statement:
You are given a table having the marks of one student in every test. 
You have to output the tests in which the student has improved his performance. 
For a student to improve his performance he has to score more than the previous test.
Provide 2 solutions, one including the first test score and second excluding it.
*/

-- drop table if exists  student_tests;
-- create table student_tests
-- (
-- 	test_id		int,
-- 	marks		int
-- );
-- insert into student_tests values(100, 55);
-- insert into student_tests values(101, 55);
-- insert into student_tests values(102, 60);
-- insert into student_tests values(103, 58);
-- insert into student_tests values(104, 40);
-- insert into student_tests values(105, 50);

-- select * from student_tests;

-- Output 1:
	-- Apporach 1:
with cte as (
select test_id, marks, marks - lag(marks,1,0) over(order by test_id) as new_marks
	from student_tests
)
select test_id, marks from cte where new_marks > 0	

	-- Apporach 2:
-- Solution INCLUDING the first test marks
select *
from (select *, lag(marks,1,0) over(order by test_id) as prev_test_mark
	from student_tests) x
where x.marks > prev_test_mark;


-- Output 2:
	-- Apporach 1:
with cte as (
select test_id, marks, marks - lag(marks,1,0) over(order by test_id) as new_marks,
	row_number() over(order by test_id) as rn
from student_tests
)
select test_id, marks from cte where new_marks > 0	and rn != 1
	-- Apporach 2:
-- Solution EXCLUDING the first test marks
select *
from (select *, lag(marks,1,marks) over(order by test_id) as prev_test_mark
	from student_tests) x
where x.marks > prev_test_mark;

-----------------------------------------------------------------------------------
--- VIDEO_Q7 ---
/* 

PROBLEM STATEMENT:
In the given input table DAY_INDICATOR field indicates the day of the week with the first character being Monday, followed by Tuesday and so on.
Write a query to filter the dates column to showcase only those days where day_indicator character for that day of the week is 1
-- PostgreSQL
drop table if exists Day_Indicator;
create table Day_Indicator
(
	Product_ID 		varchar(10),	
	Day_Indicator 	varchar(7),
	Dates			date
);
insert into Day_Indicator values ('AP755', '1010101', to_date('04-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('05-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('06-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('07-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('08-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('09-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('10-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('04-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('05-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('06-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('07-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('08-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('09-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('10-Mar-2024','dd-mon-yyyy'));

select * from Day_Indicator;
*/












-----------------------------------------------------------------------------------
--- VIDEO_Q17 ---
-- PROBLEM STATEMENT:Find out the employees who attended all company events
-- Solution 1:
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--- VIDEO_Q18 ---
-- PROBLEM STATEMENT:Find out the employees who attended all company events
-- Solution 1:
select e.name, count(distinct event_name) from events ev
join employees e on e.id = ev.emp_id
group by e.name
Having count(distinct event_name) = ( select count(distinct event_name) from events)
order by e.name

-- Solution 2:
with tbl as (
SELECT emp_id, STRING_AGG(distinct event_name, ',') AS nc
FROM events
GROUP BY emp_id
), 
cte2 as(
SELECT emp_id, COUNT(*) AS count
FROM tbl
WHERE "nc" LIKE '%Product launch%'
AND "nc" LIKE '%Conference%'
AND "nc" LIKE '%Training%'
group by emp_id
)
select id, name from cte2 e join employees em
on e.emp_id = em.id