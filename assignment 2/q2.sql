with main as (
	select  cust as CUSTOMER, prod as PRODUCT, state as STATE
	from sales
	group by CUSTOMER, PRODUCT, STATE 
	order by CUSTOMER, PRODUCT, STATE ),
Q1 as (
	select cust as CUSTOMER, prod as PRODUCT, state as STATE, avg(quant) as AVG_QUANT, 1 as QUARTER
	from sales
	where month between 1 and 3 
	group by CUSTOMER, PRODUCT, STATE 
	order by CUSTOMER ,PRODUCT ,STATE),
Q2 as (
	select cust as CUSTOMER, prod as PRODUCT, state as STATE, avg(quant) as AVG_QUANT, 2 as QUARTER
	from sales
	where month between 4 and 6 
	group by CUSTOMER, PRODUCT, STATE 
	order by CUSTOMER ,PRODUCT ,STATE),
Q3 as (
	select cust as CUSTOMER, prod as PRODUCT, state as STATE, avg(quant) as AVG_QUANT, 3 as QUARTER
	from sales
	where month between 7 and 9
	group by CUSTOMER, PRODUCT, STATE 
	order by CUSTOMER ,PRODUCT ,STATE),
Q4 as (
	select cust as CUSTOMER, prod as PRODUCT, state as STATE, avg(quant) as AVG_QUANT, 4 as QUARTER
	from sales
	where month between 10 and 12
	group by CUSTOMER, PRODUCT, STATE 
	order by CUSTOMER ,PRODUCT ,STATE),
Q5 as( 	
	select coalesce(Q1.CUSTOMER,Q2.CUSTOMER) as CUSTOMER,coalesce(Q1.PRODUCT,Q2.PRODUCT) as PRODUCT, coalesce(Q1.QUARTER,Q2.QUARTER) as QUARTER,coalesce(Q1.STATE,Q2.STATE) as STATE, cast(null as numeric) as BEFORE_AVG, Q2.AVG_QUANT as AFTER_AVG 
	from Q1 full outer join Q2 on Q1.CUSTOMER = Q2.CUSTOMER and Q1.PRODUCT = Q2.PRODUCT and Q1.STATE = Q2.STATE),
Q6 as( 
	select coalesce(Q2.CUSTOMER,Q3.CUSTOMER) as CUSTOMER ,coalesce(Q2.PRODUCT,Q3.PRODUCT) as PRODUCT, coalesce(Q2.QUARTER,Q3.QUARTER) as QUARTER ,coalesce(Q2.STATE,Q3.STATE) as STATE, Q2.AVG_QUANT as BEFORE_AVG, Q3.AVG_QUANT as AFTER_QUANT
	from Q2 full outer join Q3 on Q2.CUSTOMER = Q3.CUSTOMER and Q2.PRODUCT = Q3.PRODUCT and Q2.STATE = Q3.STATE),
Q7 as( 
	select coalesce(Q3.CUSTOMER,Q4.CUSTOMER) as CUSTOMER ,coalesce(Q3.PRODUCT,Q4.PRODUCT) as PRODUCT, coalesce(Q3.QUARTER,Q4.QUARTER) as QUARTER,coalesce(Q3.STATE,Q4.STATE) as STATE, Q3.AVG_QUANT as BEFORE_AVG, Q4.AVG_QUANT as AFTER_QUANT
	from Q3 full outer join Q4 on Q3.CUSTOMER = Q4.CUSTOMER and Q3.PRODUCT = Q4.PRODUCT and Q3.STATE = Q4.STATE),
Q8 as ( 
	select coalesce(Q4.CUSTOMER,Q3.CUSTOMER) as CUSTOMER ,coalesce(Q4.PRODUCT,Q3.PRODUCT) as PRODUCT, coalesce(Q4.QUARTER,Q3.QUARTER) as QUARTER ,coalesce(Q4.STATE,Q3.STATE) as STATE, Q3.AVG_QUANT as BEFORE_AVG, cast(null as numeric) as AFTER_AVG
	from Q4 full outer join Q3 on Q4.CUSTOMER = Q3.CUSTOMER and Q4.PRODUCT = Q3.PRODUCT and Q4.STATE = Q3.STATE)
	
select * from Q5 union select * from Q6 union select * from Q7 union select * from Q8 order by QUARTER