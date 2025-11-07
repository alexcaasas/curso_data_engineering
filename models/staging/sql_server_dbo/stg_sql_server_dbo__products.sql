{{
    config(
        materialized='view'
    )
}}

with todas_products as (
    select *
    from {{ source ('sql_server_dbo', 'products') }}
)

select * from todas_products

