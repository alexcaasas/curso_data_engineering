{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

uniendo_conductor as (
    select
    {{ dbt_utils.generate_surrogate_key([ 'dni' ]) }} as id_conductor,
    dni,
    {{ dbt_utils.generate_surrogate_key([ 'sexo' ]) }} as id_sexo,
    {{ dbt_utils.generate_surrogate_key([ 'rango_de_edade' ]) }} as id_rango_edades
    from accidentes 
)

select * from uniendo_conductor