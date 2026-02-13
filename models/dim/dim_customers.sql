with source as (
select *
from {{ ref('customers_snapshot') }}
where dbt_valid_to is not null

),
cleaned as (

    select
        user_id,
        lower(trim(email)) as email,
        trim(full_name) as full_name,
        status,
        case 
            when upper(gender) in ('M','F') then upper(gender)
            else 'UNKNOWN'
        end as gender,
        birth_date::date as birth_date,
        trim(region) as region,
        trim(city) as city,
        trim(town) as town,
        trim(district) as district,
        trim(address) as address
    from source

)

select *
from cleaned
