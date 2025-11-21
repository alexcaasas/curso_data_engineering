{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('stg_accidentes__accidente') }}
)

select * from accidentes