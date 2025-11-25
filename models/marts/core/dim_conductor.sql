{{
    config(
        materialized='incremental'
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
    c.id_conductor,
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


{% if is_incremental() %}

  where fecha_ingesta > (select max(fecha_ingesta) from {{ this }})

{% endif %}