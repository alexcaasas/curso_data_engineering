{{
    config(
        materialized='view'
    )
}}

with provincias as (
    select id_provincia
    from {{ ref ('stg_accidentes__provincia') }}
),

vehiculos as (
    select id_vehiculo
    from {{ ref ('stg_accidentes__vehiculo') }}
),

motivos as (
    select id_motivo
    from {{ ref ('stg_accidentes__motivo') }}
),

conductores as (
    select id_conductor
    from {{ ref ('stg_accidentes__conductor')}}
),

vias as (
    select id_via
    from {{ ref ('stg_accidentes__via')}}
),

valores_base as (
    select 
    {{ dbt_utils.generate_surrogate_key([ 'zona' ]) }} as id_via,
    {{ dbt_utils.generate_surrogate_key([ 'provincia' ]) }} as id_provincia,
    {{ dbt_utils.generate_surrogate_key([ 'matricula' ]) }} as id_vehiculo,
    {{ dbt_utils.generate_surrogate_key([ 'dni' ]) }} as id_conductor,
    victimas_mortales
    from {{ source ('desarrollo', 'accidentes_final') }}
)


select * from valores_base