{% snapshot customers_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='check',
      check_cols=['city', 'status'],
      invalidate_hard_deletes=True
    )
}}

select
    user_id,
    email,
    full_name,
    status,
    gender,
    birth_date,
    region,
    city,
    town,
    district,
    address
from {{ ref('stg_customers') }}

{% endsnapshot %}
