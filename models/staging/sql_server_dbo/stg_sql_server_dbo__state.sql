{{
    config(
        materialized='view'
    )
}}

with todas_addresses as (
    select *
    from {{ source ('sql_server_dbo', 'addresses') }}
),

uniendo_state as (
    select
    md5(state)::varchar as state_id,
    state::varchar as state,
    md5(country) as country_id
    from todas_addresses 
)

select * from uniendo_state