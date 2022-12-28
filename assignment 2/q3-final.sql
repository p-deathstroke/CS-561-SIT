with main as (
  select prod, quant
  from sales
  order by prod, quant),
 Q1 as (
  select prod, quant, 
 (select count(quant) 
  from sales 
  where quant <= main.quant and prod = main.prod) AS TEMP
  from main),
 Q2 as (
  select prod, max(TEMP) AS MAX_TEMP
  from Q1
  where prod = Q1.prod 
  group by prod),
 Q3 as (
  select Q1.prod, ceil((cast((min(TEMP) + max(TEMP)) as float))/2) as CEIL_QUANT
  from Q1, Q2
  where Q1.prod = Q2.prod and Q1.TEMP <> Q2.MAX_TEMP
  group by Q1.prod
  order by prod),
 Q4 as (
  select Q1.prod, Q1.quant, Q1.TEMP 
  from Q1, Q3
  where Q1.prod = Q3.prod and Q1.TEMP <= Q3.CEIL_QUANT
  order by Q1.prod, Q1.quant),
 Q5 as (
  select Q1.prod, Q1.quant 
  from Q1, Q4
  where Q1.prod = Q4.prod and Q1.TEMP = (select max(TEMP) from Q4 where prod=Q1.prod group by prod)
  order by Q1.prod, Q1.quant)
  
select prod as "PRODUCT", max(quant) as "MEDIAN QUANT"
from Q5 
group by prod 
order by prod