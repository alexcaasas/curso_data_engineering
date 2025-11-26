{{
    config(
        materialized='view'
    )
}}

with todos_accidentes as (
    select * 
    from {{ ref ('fct_accidente')}}
),

todos_motivos as (
    select *
    from {{ ref ('dim_motivo') }}
),

junto as (
    select a.id_accidente, 
    a.num_victimas_mortales,
    m.motivo
    from todos_accidentes a
    left join todos_motivos m 
        on a.id_motivo = m.id_motivo
),

motivo_accidentado as (
    select motivo,
    count(*) as num_accidentes,
    sum(num_victimas_mortales) as num_victimas_mortales
    from junto
    where motivo <> 'Limpio'
    group by motivo
    order by num_accidentes desc
)

select * from motivo_accidentado

