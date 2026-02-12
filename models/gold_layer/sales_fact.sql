with orders as (
    select * from {{ ref('stg_orders') }}
),

order_details as (
    select * from {{ ref('stg_order_details') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

branches as (
    select * from {{ ref('stg_branches') }}
),

categories as (
    select * from {{ ref('stg_categories') }}
)

select
    o.order_id,
    o.order_ts,
    o.user_id,
    c.email,
    c.gender,

    o.branch_id,
    b.region,
    b.city,
    b.town,

    od.item_id,
    cat.item_name,
    cat.brand,

    od.quantity,
    od.unit_price,
    od.total_price

from orders o

join order_details od
    on o.order_id = od.order_id

left join customers c
    on o.user_id = c.user_id

left join branches b
    on o.branch_id = b.branch_id

left join categories cat
    on od.item_id = cat.item_id
