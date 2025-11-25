{{
    config(
        materialized='incremental'
    )
}}

with accidentes as (
    select *
    from {{ ref ('stg_accidentes__accidente') }}
)

select * from accidentes


{% if is_incremental() %}

  where fecha_ingesta > (select max(fecha_ingesta) from {{ this }})

{% endif %}