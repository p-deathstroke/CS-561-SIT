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
Q5 as ( 
	select main.CUSTOMER,main.PRODUCT,main.STATE,main.QUARTER,cast(null as numeric) as BEFORE_AVG, Q1.AVG_QUANT as AFTER_AVG
	from main full outer join Q1 on Q1.CUSTOMER = main.CUSTOMER and Q1.PRODUCT=main.PRODUCT and Q1.STATE= main.STATE
	group by Q1.CUSTOMER,Q1.PRODUCT,Q1.STATE,Q1.QUARTER,Q1.AVG_QUANT
	order by Q1.CUSTOMER,Q1.PRODUCT,Q1.STATE,Q1.QUARTER),
Q6 as ( 
	select Q.CUSTOMER,Q1.PRODUCT,Q1.STATE,Q1.QUARTER,cast(null as numeric) as BEFORE_AVG, Q1.AVG_QUANT as AFTER_AVG
	from main full outer join Q1 on Q1.CUSTOMER = main.CUSTOMER and Q1.PRODUCT=main.PRODUCT and Q1.STATE= main.STATE
	group by Q1.CUSTOMER,Q1.PRODUCT,Q1.STATE,Q1.QUARTER,Q1.AVG_QUANT
	order by Q1.CUSTOMER,Q1.PRODUCT,Q1.STATE,Q1.QUARTER),
	
	
	