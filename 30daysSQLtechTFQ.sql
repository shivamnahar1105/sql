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