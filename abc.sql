with product_sales as (select
        dr_ndrugs as product,
        sum(dr_kol) as amount,
        sum(dr_kol*(dr_croz - dr_czak) - dr_sdisc) as profit,
        sum(dr_kol*dr_croz - dr_sdisc) as revenue
    from sales s
    group by dr_ndrugs
)
select product, 
		case when sum(amount) over(order by amount desc) / sum(amount) over() <= 0.8 then 'A'
	when sum(amount) over(order by amount desc) / sum(amount) over() <= 0.95 then 'B'
	else 'C' 
	end as amount_abc,	
		case when sum(profit) over(order by profit desc) / sum(profit) over() <= 0.8 then 'A'
	when sum(profit) over(order by profit desc) / sum(profit) over() <= 0.95 then 'B'
	else 'C' 
	end as profit_abc,	
		case when sum(revenue) over(order by revenue desc) / sum(revenue) over() <= 0.8 then 'A'
	when sum(revenue) over(order by revenue desc) / sum(revenue) over() <= 0.95 then 'B'
	else 'C' 
	end as revenue_abc
from product_sales



