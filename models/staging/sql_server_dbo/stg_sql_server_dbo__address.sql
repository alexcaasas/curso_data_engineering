{{
    config(
        materialized='view'
    )
}}

with todas_addresses as (
    select *
    from {{ source ('sql_server_dbo', 'addresses') }}
),

uniendo_addresses as (
    select
    md5(address)::varchar as addresses_id,
    address::varchar as address_name,
    md5(zipcode) as zipcode_id,
    from todas_addresses 
)

select * from uniendo_addresses