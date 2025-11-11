{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes') }}
),

uniendo_edades as (
    select
    distinct {{ dbt_utils.generate_surrogate_key([ 'rango_de_edade' ]) }} as id_rango_edades,
    rango_de_edade::varchar as rango_edades,
    from accidentes 
)

select * from uniendo_edades