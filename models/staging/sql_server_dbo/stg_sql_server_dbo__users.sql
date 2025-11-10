{{
    config(
        materialized='view'
    )
}}

with todas_users as (
    select *
    from {{ source ('sql_server_dbo', 'users') }}
),

limpio_users as (
    select 
    user_id,
    address_id,
    first_name,
    last_name,
    phone_number,
    email,
    CONVERT_TIMEZONE('UTC', created_at) as created_at_utc,
    CONVERT_TIMEZONE('UTC', updated_at) as updated_at_utc,
    _fivetran_deleted,
    CONVERT_TIMEZONE('UTC', _fivetran_synced) as _fivetran_synced_utc
    from todas_users
)

select * from limpio_users