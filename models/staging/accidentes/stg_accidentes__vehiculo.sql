{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

uniendo_tipo_vehiculo as (
    select
    distinct {{ dbt_utils.generate_surrogate_key([ 'matricula' ]) }} as id_vehiculo,
    matricula,
    {{ dbt_utils.generate_surrogate_key([ 'tipo_vehiculo' ]) }} as id_tipo_vehiculo
    from accidentes 
)

select * from uniendo_tipo_vehiculo