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
	 select main.CUSTOMER, main.PRODUCT, main.STATE, 1 as Q1 , cast (NULL as NUMERIC) as BEFORE_AVG, Q2.AVG_QUANT as AFTER_AVG 
	 from main left outer join Q2
	 on main.CUSTOMER = Q2.CUSTOMER and main.PRODUCT = Q2.PRODUCT and main.STATE = Q2.STATE
	 group by main.CUSTOMER, main.PRODUCT, main.STATE, Q2.QUARTER, Q2.AVG_QUANT
	 order by main.CUSTOMER, main.PRODUCT, main.STATE, Q2.QUARTER, Q2.AVG_QUANT),
Q6 as (
	select main.CUSTOMER, main.PRODUCT, main.STATE, 2 as Q1 , Q1.AVG_QUANT as BEFORE_AVG, Q3.AVG_QUANT as AFTER_AVG 
	from main left outer join Q1
	on main.CUSTOMER = Q1.CUSTOMER and main.PRODUCT = Q1.PRODUCT and main.STATE = Q1.STATE
	left outer join Q3
	on Q3.CUSTOMER = Q1.CUSTOMER and Q3.PRODUCT= Q1.PRODUCT and Q3.STATE = Q1.STATE
	group by main.CUSTOMER, main.PRODUCT, main.STATE, Q1.QUARTER, Q1.AVG_QUANT,Q3.AVG_QUANT
	order by main.CUSTOMER, main.PRODUCT, main.STATE, Q1.QUARTER, Q1.AVG_QUANT,Q3.AVG_QUANT),
Q7 as(
	 select main.CUSTOMER, main.PRODUCT, main.STATE, 3 as Q1 , Q3.AVG_QUANT as BEFORE_AVG, Q4.AVG_QUANT as AFTER_AVG 
 	 from main left outer join Q3
	 on main.CUSTOMER = Q3.CUSTOMER and main.PRODUCT = Q3.PRODUCT and main.STATE = Q3.STATE
	 left outer join Q4 
	 on Q4.CUSTOMER = Q3.CUSTOMER and Q4.PRODUCT= Q3.PRODUCT and Q4.STATE = Q3.STATE
	 group by main.CUSTOMER, main.PRODUCT, main.STATE, Q3.QUARTER, Q4.AVG_QUANT,Q3.AVG_QUANT
	 order by main.CUSTOMER, main.PRODUCT, main.STATE, Q3.QUARTER, Q4.AVG_QUANT,Q3.AVG_QUANT),
Q8 as (
	 select main.CUSTOMER, main.PRODUCT, main.STATE, 4 as Q1, Q3.AVG_QUANT as BEFORE_AVG, cast (NULL as NUMERIC) as AFTER_AVG 
	 from main left outer join Q3
	 on main.CUSTOMER = Q3.CUSTOMER and main.PRODUCT = Q3.PRODUCT and main.STATE = Q3.STATE
	 group by main.CUSTOMER,main.PRODUCT, main.STATE, Q3.QUARTER, Q3.AVG_QUANT
	 order by main.CUSTOMER, main.PRODUCT, main.STATE, Q3.QUARTER, Q3.AVG_QUANT)

	select * from Q5 union select * from Q6 union select * from Q7  union select * from Q8 
	group by CUSTOMER, PRODUCT,STATE,Q1,before_avg,after_avg
	order by q1
	 
