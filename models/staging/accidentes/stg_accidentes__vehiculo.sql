{{
    config(
        materialized='incremental'
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
    id_tipo_vehiculo,
    fecha_ingesta
    from accidentes 
)

select * from uniendo_tipo_vehiculo

{% if is_incremental() %}

  where fecha_ingesta > (select max(fecha_ingesta) from {{ this }})

{% endif %}