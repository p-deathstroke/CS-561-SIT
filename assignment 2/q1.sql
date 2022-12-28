with Q1 as (
	select cust as CUSTOMER, prod as PRODUCT, month as MONTH, state as STATE, avg(quant) as CUST_AVG
	from sales
	group by CUSTOMER, PRODUCT, STATE, MONTH
	order by CUSTOMER ),
	
	Q2 as (
	select Q1.CUSTOMER, Q1.PRODUCT, Q1.MONTH, Q1.STATE, avg(sales.quant) as OTHER_PROD_AVG
	from Q1,sales
	where Q1.CUSTOMER = sales.cust and Q1.PRODUCT != sales.prod and Q1.MONTH= sales.month and Q1.STATE = sales.state
	group by Q1.CUSTOMER, Q1.PRODUCT, Q1.STATE, Q1.MONTH
	order by Q1.CUSTOMER ),
	
	Q3 as (
	select Q1.CUSTOMER, Q1.PRODUCT, Q1.MONTH, Q1.STATE, avg(sales.quant) as OTHER_MONTH_AVG
	from Q1,sales
	where Q1.CUSTOMER = sales.cust and Q1.PRODUCT = sales.prod and Q1.MONTH != sales.month and Q1.STATE = sales.state
	group by Q1.CUSTOMER, Q1.PRODUCT, Q1.STATE, Q1.MONTH
	order by Q1.CUSTOMER ),
	
	Q4 as (
	select Q1.CUSTOMER, Q1.PRODUCT, Q1.MONTH, Q1.STATE, avg(sales.quant) as OTHER_STATE_AVG
	from Q1,sales
	where Q1.CUSTOMER = sales.cust and Q1.PRODUCT = sales.prod and Q1.MONTH= sales.month and Q1.STATE != sales.state
	group by Q1.CUSTOMER, Q1.PRODUCT, Q1.STATE, Q1.MONTH
	order by Q1.CUSTOMER )
	
	select Q1.CUSTOMER, Q1.PRODUCT,Q1.MONTH,Q1.STATE, Q1.CUST_AVG, Q2.OTHER_PROD_AVG, Q3.OTHER_MONTH_AVG, Q4.OTHER_STATE_AVG
	from Q1 full outer join Q2 on Q1.CUSTOMER = Q2.CUSTOMER and Q1.PRODUCT = Q2.PRODUCT and Q1.MONTH = Q2.MONTH and Q1.STATE = Q2.STATE
		    full outer join Q3 on Q1.CUSTOMER = Q3.CUSTOMER and Q1.PRODUCT = Q3.PRODUCT and Q1.MONTH = Q3.MONTH and Q1.STATE = Q3.STATE
		    full outer join Q4 on Q1.CUSTOMER = Q4.CUSTOMER and Q1.PRODUCT = Q4.PRODUCT and Q1.MONTH = Q4.MONTH and Q1.STATE = Q4.STATE