{{
    config(
        materialized='view'
    )
}}

with sexo as (
    select *
    from {{ ref ('stg_accidentes__sexo') }}
),

rango_edades as (
    select *
    from {{ ref ('stg_accidentes__rango_edades') }}
),

conductor as (
    select
    {{ dbt_utils.generate_surrogate_key([ 'c.dni' ]) }} as id_conductor,
    c.dni,
    s.sexo,
    re.rango_edad
    from {{ ref ('stg_accidentes__conductor')}} c
    left join rango_edades re
        on re.id_rango_edades= c.id_rango_edades
    left join sexo s
        on s.id_sexo = c.id_sexo
)

select * from conductor