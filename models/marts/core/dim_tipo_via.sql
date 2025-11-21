{{
    config(
        materialized='table'
    )
}}

with tipo_via as (
    select *
    from {{ ref ('stg_accidentes__tipo_via') }}
)

select * from tipo_via