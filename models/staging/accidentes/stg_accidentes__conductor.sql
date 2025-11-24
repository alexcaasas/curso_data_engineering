{{
    config(
        materialized='incremental'
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
    id_rango_edades,
    fecha_ingesta
    from accidentes 
)

select * from uniendo_conductor


{% if is_incremental() %}

  where fecha_ingesta > (select max(fecha_ingesta) from {{ this }})

{% endif %}