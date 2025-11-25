{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

uniendo_tipo_vehiculo as (
    select
    distinct id_vehiculo,
    matricula,
    id_tipo_vehiculo
    from accidentes 
)

select * from uniendo_tipo_vehiculo