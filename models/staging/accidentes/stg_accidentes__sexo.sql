{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

uniendo_sexo as (
    select
    distinct id_sexo,
    sexo
    from accidentes 
)

select * from uniendo_sexo