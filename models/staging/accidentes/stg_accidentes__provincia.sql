{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

uniendo_provincias as (
    select
    distinct id_provincia,
    CASE 
        WHEN provincia = 'Araba/Álava' THEN SPLIT_PART(provincia, '/', 2)
        ELSE SPLIT_PART(provincia, '/', 1)
    END as provincia,
    id_com_autonoma
    from accidentes 
)

select * from uniendo_provincias