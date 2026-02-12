{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('landing_layer', 'ORDER_DETAILS') }}

),

cleaned as (

    select
        cast(order_id as integer) as order_id,

        cast(order_detail_id as integer) as order_detail_id,

        cast(amount as integer) as quantity,

        cast(replace(unit_price, ',', '.') as number(18,2)) as unit_price,

        cast(replace(total_price, ',', '.') as number(18,2)) as total_price,

        cast(item_id as integer) as item_id,

        cast(item_code as integer) as item_code

    from source

)

select *
from cleaned
