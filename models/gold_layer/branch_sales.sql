with sales as (
    select * from {{ ref('sales_fact') }}
)

select
    branch_id,
    region,
    city,
    date(order_ts) as order_date,

    count(distinct order_id) as total_orders,
    sum(quantity) as total_units_sold,
    sum(total_price) as total_revenue,
    sum(total_price) 
        / nullif(count(distinct order_id), 0) as avg_order_value

from sales
group by 
    branch_id,
    region,
    city,
    date(order_ts)
