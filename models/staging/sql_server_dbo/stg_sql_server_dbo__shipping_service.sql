{{
    config(
        materialized='view'
    )
}}

with todas_orders as (
    select *
    from {{ source ('sql_server_dbo', 'orders') }}
),

limpio_shipping as (
    select
    distinct md5(shipping_service) as id_shipping_service,
    shipping_service as shipping_service_name
    from todas_orders
)

select * from limpio_shipping