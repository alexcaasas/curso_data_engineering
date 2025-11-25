{{
    config(
        materialized = 'incremental',
        incremental_strategy='merge',
        unique_key='id_accidente'
    )
}}



with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

valores_base as (
    select 
    id_accidente,
    id_conductor,
    id_provincia,
    id_vehiculo,
    id_via,
    TO_DATE(data, 'DD/MM/YYYY') AS fecha_accidente,
    matricula,
    victimas_mortales as num_victimas_mortales,
    resultado_toxicoloxico as test_toxicologico,
    id_motivo,
    dni,
    fecha_ingesta
    from accidentes
    QUALIFY ROW_NUMBER() OVER (PARTITION BY id_accidente ORDER BY fecha_ingesta desc) = 1
)

select * from valores_base

{% if is_incremental() %}

  where fecha_ingesta > (select max(fecha_ingesta) from {{ this }})

{% endif %}

