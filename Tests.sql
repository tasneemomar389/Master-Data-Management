-----Test Dups value -----

with cte_actual as 
(
select customer_id as value , 'dim_customer' as label
from `star_schema.dim_customer`
group by customer_id having count(*) >1 
union all
select product_id as value , 'dim_product' as label
from `star_schema.dim_product`
group by product_id having count(*) >1 
union all
select cast(address_id as string) as value , 'dim_address' as label
from `star_schema.dim_address`
group by address_id having count(*) >1 
union all
select order_product_id as value , 'fact_orders' as label
from `star_schema.fact_orders`
group by order_product_id having count(*) >1 
)
select *
from cte_actual ;



-------Test fact_orders missing orders---------

with cte_actual as
(
select order_product_id as value 
from `star_schema.fact_orders`
) 
,
cte_expected as
(
select distinct CONCAT(Order_ID, '-', Product_ID) as value 
from `orders.order_details`
) 
select * 
from cte_expected
where value not in ( select value from cte_actual )


