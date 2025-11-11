{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes') }}
),

uniendo_conductor as (
    select
    {{ dbt_utils.generate_surrogate_key([ 'sexo' ]) }} as id_conductor,
    sexo,
    {{ dbt_utils.generate_surrogate_key([ 'rango_de_edade' ]) }} as id_rango_edades
    from accidentes 
)

select * from uniendo_conductor