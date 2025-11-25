{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

uniendo_conductor as (
    select
    distinct id_conductor,
    dni,
    id_sexo,
    id_rango_edades
    from accidentes 
)

select * from uniendo_conductor