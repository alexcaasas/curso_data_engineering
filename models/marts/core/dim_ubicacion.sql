{{
    config(
        materialized='view'
    )
}}

with provincias as (
    select *
    from {{ ref ('stg_accidentes__provincia') }}
),

com_autonomas as (
    select *
    from {{ ref ('stg_accidentes__com_autonoma') }}
),

ubicacion as (
    select
    p.id_provincia, 
    p.provincia,
    ca.com_autonoma
    from provincias p
    left join com_autonomas ca
        on p.id_com_autonoma = ca.id_com_autonoma
)

select * from ubicacion