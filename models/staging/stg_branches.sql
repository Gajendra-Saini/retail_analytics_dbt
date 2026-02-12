{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('landing_layer', 'BRANCHES') }}

),

cleaned as (

    select
        trim(branch_id) as branch_id,

        initcap(trim(region)) as region,
        initcap(trim(city)) as city,
        initcap(trim(town)) as town,
        initcap(trim(branch_town)) as branch_town,

        cast(latitude as number) / 100000000 as latitude,
        cast(longitude as number) / 100000000 as longitude

    from source

)

select *
from cleaned
