{{
    config(
        materialized='view'
    )
}}

with todas_addresses as (
    select *
    from {{ source ('sql_server_dbo', 'addresses') }}
),

limpio_addresses as (
    select
    address_id::varchar as address_id,
    md5(address)::varchar as addresses_id,
    _fivetran_deleted as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC', _fivetran_synced) as _fivetran_synced_utc
    from todas_addresses
)

select * from limpio_addresses