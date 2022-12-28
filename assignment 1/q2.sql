with Q1 as (
	select cust as CUSTOMER,prod as PRODUCT, max(quant) as OCT_MAX
	from sales
	where year>2017 and month =10
	group by cust,prod
),
 Q2 as ( 
	select Q1.CUSTOMER,Q1.PRODUCT, Q1.OCT_MAX,sales.date as OCT_DATE
	from Q1, sales
	where sales.cust = Q1.CUSTOMER and sales.prod = Q1.PRODUCT and Q1.OCT_MAX = sales.quant and sales.year>2017 and sales.month =10
),
 Q3 as (
	select cust as CUSTOMER,prod as PRODUCT, min(quant) as NOV_MIN
	from sales
	where month =11
	group by cust,prod
),
 Q4 as ( 
	select Q3.CUSTOMER,Q3.PRODUCT, Q3.NOV_MIN,sales.date as NOV_DATE
	from Q3,sales
	where sales.cust = Q3.CUSTOMER and sales.prod = Q3.PRODUCT and Q3.NOV_MIN = sales.quant and sales.month =11
),
Q5 as (
	select cust as CUSTOMER,prod as PRODUCT, min(quant) as DEC_MIN
	from sales
	where month =12
	group by cust,prod
),
Q6 as ( 
	select Q5.CUSTOMER,Q5.PRODUCT, Q5.DEC_MIN,sales.date as DEC_DATE
	from Q5,sales
	where sales.cust = Q5.CUSTOMER and sales.prod = Q5.PRODUCT and Q5.DEC_MIN = sales.quant and sales.month =12
)
	select Q4.CUSTOMER,Q4.PRODUCT, Q2.OCT_MAX,Q2.OCT_DATE,Q4.NOV_MIN,Q4.NOV_DATE,Q6.DEC_MIN,Q6.DEC_DATE
	from Q2 full outer join Q4 on Q2.CUSTOMER = Q4.CUSTOMER and Q2.PRODUCT=Q4.PRODUCT full outer join Q6 on Q4.CUSTOMER = Q6.CUSTOMER and Q4.PRODUCT = Q6.PRODUCT
