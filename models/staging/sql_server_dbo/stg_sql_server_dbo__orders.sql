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
    distinct md5(shipping_service) as id_shipping_service,
    shipping_cost as shipping_cost_usd,
    address_id,
    CONVERT_TIMEZONE('UTC', created_at) as created_at_utc,
    promo_id,
    CONVERT_TIMEZONE('UTC', estimated_delivery_at) as estimated_delivery_at_utc,
    order_cost as order_cost_usd,
    md5(status) as status_id,
    _fivetran_deleted,
    CONVERT_TIMEZONE('UTC', _fivetran_synced) as _fivetran_synced_utc
    from todas_orders
)

select * from limpio_orders