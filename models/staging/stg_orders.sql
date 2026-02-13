{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('landing_layer', 'ORDERS') }}

),

cleaned as (

    select
        cast(order_id as integer) as order_id,

        trim(branch_id) as branch_id,

        cast(order_ts as timestamp) as order_ts,

        cast(user_id as integer) as user_id,

        trim(full_name) as full_name,

        -- Fix decimal comma and convert to numeric
        cast(replace(total_basket, ',', '.') as number(18,2)) as total_basket

    from source

)

select *
from cleaned
