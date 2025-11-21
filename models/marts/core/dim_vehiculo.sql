{{
    config(
        materialized='table'
    )
}}

with tipo_vehiculo as (
    select *
    from {{ ref ('stg_accidentes__tipo_vehiculo') }}
),

vehiculo as (
    select
    v.id_vehiculo,
    v.matricula,
    tv.tipo_vehiculo
    from {{ ref ('stg_accidentes__vehiculo')}} v
    left join tipo_vehiculo tv
        on tv.id_tipo_vehiculo = v.id_tipo_vehiculo
)

select * from vehiculo