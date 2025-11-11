{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes') }}
),

uniendo_provincias as (
    select
    distinct {{ dbt_utils.generate_surrogate_key([ 'provincia' ]) }} as id_provincia,
    SPLIT_PART(provincia, '/', 1) as provincia,
    {{ dbt_utils.generate_surrogate_key([ 'ccaa' ]) }} as id_com_autonoma
    from accidentes 
)

select * from uniendo_provincias