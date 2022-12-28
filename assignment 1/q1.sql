 with part1 as (
	select cust as CUSTOMER, min(quant) as MIN_Q, max(quant) as MAX_Q , avg(quant) as AVG_Q
	from sales
	group by cust
	),
 part2 as (
	select part1.CUSTOMER, part1.MIN_Q,sales.prod as MIN_PROD,sales.date as MIN_DATE,sales.state as ST, part1.MAX_Q,part1.AVG_Q
	from part1,sales
	where part1.CUSTOMER = sales.cust and part1.MIN_Q= sales.quant
	)
	select part2.CUSTOMER, part2.MIN_Q,part2.MIN_PROD,part2.MIN_DATE,part2.ST,part2.MAX_Q,sales.prod as MAX_PROD,sales.date as MAX_DATE,sales.state as ST,part2.AVG_Q
	from part2,sales
	where part2.CUSTOMER = sales.cust and part2.MAX_Q= sales.quant