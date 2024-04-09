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