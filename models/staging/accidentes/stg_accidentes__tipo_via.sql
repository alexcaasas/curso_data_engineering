{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

uniendo_vias as (
    select
    distinct id_via,
    zona::varchar as tipo_via
    from accidentes 
)

select * from uniendo_vias