{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('landing_layer', 'CATEGORIES') }}

),

cleaned as (

    select
        cast(item_id as integer) as item_id,

        trim(category1) as category_level_1,
        cast(category1_id as number) as category_level_1_id,

        trim(category2) as category_level_2,
        trim(category2_id) as category_level_2_id,

        trim(category3) as category_level_3,
        trim(category3_id) as category_level_3_id,

        trim(category4) as category_level_4,
        trim(category4_id) as category_level_4_id,

        upper(trim(brand)) as brand,

        cast(item_code as integer) as item_code,

        trim(item_name) as item_name

    from source

)

select *
from cleaned
