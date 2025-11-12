{{
    config(
        materialized='view'
    )
}}

with todas_addresses as (
    select *
    from {{ source ('sql_server_dbo', 'addresses') }}
),

uniendo_country as (
    select
    md5(country) as country_id,
    country::varchar as country,
    from todas_addresses 
)

select * from uniendo_country