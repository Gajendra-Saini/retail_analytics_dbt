with source as (

    select *
    from {{ source('landing_layer', 'CUSTOMERS') }}

),

city_map as (

    select *
    from {{ ref('city_mapping') }}

),

cleaned as (

    select
        s.user_id,
        lower(trim(s.email)) as email,
        trim(s.full_name) as full_name,
        s.status,

        case 
            when upper(s.gender) in ('M','F') then upper(s.gender)
            else 'UNKNOWN'
        end as gender,

        s.birth_date::date as birth_date,

        cm.region_name as region,  
        trim(s.city) as city,
        trim(s.town) as town,
        trim(s.district) as district,
        trim(s.address) as address,

        cm.pincode   

    from source s
    left join city_map cm
        on upper(trim(s.city)) = upper(cm.city)

)

select *
from cleaned
