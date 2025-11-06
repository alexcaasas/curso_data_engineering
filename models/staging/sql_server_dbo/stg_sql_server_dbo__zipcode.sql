{{
    config(
        materialized='view'
    )
}}

with todas_addresses as (
    select *
    from {{ source ('sql_server_dbo', 'addresses') }}
),

uniendo_zipcode as (
    select
    md5(zipcode)::varchar as zipcode_id,
    zipcode::number as zipcode,
    md5(state) as state_id
    from todas_addresses 
)

select * from uniendo_zipcode