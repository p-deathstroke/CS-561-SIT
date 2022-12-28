with Q1 as(
	select prod as PRODUCT,quant as QUANT
	from sales 
	group by PRODUCT, QUANT),
Q2 as(
	select Q1.PRODUCT, (count(Q1.QUANT)/2)+1 as MEDIAN 
	from Q1
	group by Q1.PRODUCT 
	order by Q1.PRODUCT),
Q3 as(
	select Q1.PRODUCT, Q1.QUANT, count(TEMP_TABLE.QUANT) 
	from Q1 join Q1 as TEMP_TABLE on TEMP_TABLE.QUANT <= Q1.QUANT and Q1.PRODUCT = TEMP_TABLE.PRODUCT 
	group by Q1.PRODUCT, Q1.QUANT 
	order by Q1.PRODUCT, Q1.QUANT)
	
	select Q3.PRODUCT, Q3.QUANT as "MEDIAN QUANT" 
	from Q3 join Q2 on Q3.PRODUCT = Q2.PRODUCT and Q3.COUNT = Q2.MEDIAN