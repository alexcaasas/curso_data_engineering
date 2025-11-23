{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

uniendo_edades as (
    select
    distinct id_rango_edades,
    rango_de_edade::varchar as rango_edad
    from accidentes 
)

select * from uniendo_edades