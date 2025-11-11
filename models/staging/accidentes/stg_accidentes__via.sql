{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes') }}
),

uniendo_vias as (
    select
    distinct {{ dbt_utils.generate_surrogate_key([ 'zona' ]) }} as id_via,
    zona::varchar as via,
    from accidentes 
)

select * from uniendo_vias