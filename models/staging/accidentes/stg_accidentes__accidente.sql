{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref ('base_source') }}
),

valores_base as (
    select 
    {{ dbt_utils.generate_surrogate_key([ 'dni','provincia', 'matricula', 'zona', 'data', 'Etanol', 'Drogas' ]) }} as id_accidente,
    id_conductor,
    id_provincia,
    id_vehiculo,
    id_via,
    TO_DATE(data, 'DD/MM/YYYY') AS fecha_accidente,
    matricula,
    victimas_mortales as num_victimas_mortales,
    resultado_toxicoloxico as test_toxicologico,
    id_motivo
    from accidentes
)

select * from valores_base

--{% if is_incremental() %}

--  where fecha_accidente > (select max(fecha_accidente) from {{ this }})

--{% endif %}