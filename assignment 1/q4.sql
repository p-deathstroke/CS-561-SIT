with Q1 as (
  	select prod as PRODUCT,sum(quant) as SUM_QUANT, month as MONTH
  	from sales
  	group by prod,month
  	order by prod,month
 	),
Q2 as ( 
   	select Q1.PRODUCT, min(SUM_QUANT) as LEAST_FAV, max(SUM_QUANT) as MOST_FAV
  	from Q1 	
  	group by PRODUCT  
  	),
Q3 as( 
  	select Q1.PRODUCT,Q1.MONTH as MOST_FAV_MONTH, Q2.MOST_FAV
  	from Q2,Q1
  	where Q1.SUM_QUANT = Q2.MOST_FAV and Q1.PRODUCT = Q2.PRODUCT
  	)
select Q3.PRODUCT,Q1.MONTH as LEAST_FAV_MONTH, Q3.MOST_FAV_MONTH
from Q1,Q2,Q3
where Q1.SUM_QUANT=Q2.LEAST_FAV and Q2.PRODUCT=Q3.PRODUCT

