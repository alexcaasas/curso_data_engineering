{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select * 
    from {{ ref ('stg_accidentes__accidente') }}
),

tipos_vias as (
    select *
    from {{ ref ('dim_tipo_via') }}
),

ubicaciones as (
    select * 
    from {{ ref ('dim_ubicacion')}}
),

conductores as (
    select *
    from {{ ref ('dim_conductor')}}
),

fechas as (
    select *
    from {{ ref ('dim_fecha')}}
),

motivos as (
    select *
    from {{ ref ('dim_motivo')}}
),

vehiculos as (
    select *
    from {{ ref ('dim_vehiculo')}}
),

hecho_accidente as (
    select 
    c.id_conductor,
    v.id_vehiculo,
    f.id_fecha,
    u.id_ubicacion,
    m.id_motivo,
    tv.id_tipo_via,
    b.num_victimas_mortales
    from accidentes b
    left join ubicaciones u 
        on u.id_ubicacion = b.
)

select * from tipo_via