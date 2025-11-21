{{
    config(
        materialized='table'
    )
}}

with motivos as (
    select *
    from {{ ref ('stg_accidentes__motivo') }}
)

select * from motivos