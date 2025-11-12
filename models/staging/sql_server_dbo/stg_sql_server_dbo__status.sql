{{
    config(
        materialized='view'
    )
}}

with todas_orders as (
    select *
    from {{ source ('sql_server_dbo', 'orders') }}
),

limpio_orders as (
    select
    distinct md5(status) as status_id,
    status
    from todas_orders
)

select * from limpio_orders