 with Q1 as (
 	select cust as CUSTOMER , prod as PRODUCT, avg(quant) as AVG_QUANT,sum(quant) as TOTAL_SUM_QUANT, count(quant) as COUNT_QUANT
 	from sales 
 	where year between 2016 and 2020 
 	group by cust, prod 
 	),
 ct as (
 	select cust as CUSTOMER , prod as PRODUCT, avg(quant) as CT_AVG
 	from sales 
 	where year between 2016 and 2020 and state = 'CT' 
 	group by cust, prod 
 	),
 ny as (
 	select cust as CUSTOMER , prod as PRODUCT, avg(quant) as NY_AVG
 	from sales 
 	where year between 2016 and 2020 and state = 'NY' 
 	group by cust, prod 
 	),
 nj as (
 	select cust as CUSTOMER , prod as PRODUCT, avg(quant) as NJ_AVG
 	from sales 
 	where year between 2016 and 2020 and state = 'NJ' 
 	group by cust, prod 
 	),
 pa as (
 	select cust as CUSTOMER , prod as PRODUCT, avg(quant) as PA_AVG
 	from sales 
 	where year between 2016 and 2020 and state = 'PA' 
 	group by cust, prod 
 	)
	
 	select Q1.CUSTOMER,Q1.PRODUCT, ct.CT_AVG,ny.NY_AVG,nj.NJ_AVG,pa.PA_AVG,Q1.AVG_QUANT, Q1.TOTAL_SUM_QUANT, Q1.COUNT_QUANT
	from Q1 full outer join ct on ct.CUSTOMER = Q1.CUSTOMER and ct.PRODUCT = Q1.PRODUCT
			full outer join ny on ct.CUSTOMER = ny.CUSTOMER and ct.PRODUCT = ny.PRODUCT
			full outer join nj on ny.CUSTOMER = nj.CUSTOMER and ny.PRODUCT = nj.PRODUCT
			full outer join pa on nj.CUSTOMER = pa.CUSTOMER and nj.PRODUCT = pa.PRODUCT
