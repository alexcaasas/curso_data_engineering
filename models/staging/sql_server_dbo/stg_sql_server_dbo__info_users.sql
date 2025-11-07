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
    first_name,
    last_name,
    phone_number,
    email,
    from todas_users
)

select * from limpio_users