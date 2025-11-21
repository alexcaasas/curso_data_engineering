{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

valores_base as (
    select 
    {{ dbt_utils.generate_surrogate_key([ 'dni','provincia', 'matricula', 'zona', 'data', 'Etanol', 'Drogas' ]) }} as id_accidente,
    {{ dbt_utils.generate_surrogate_key([ 'dni' ]) }} as id_conductor,
    {{ dbt_utils.generate_surrogate_key([ 'provincia' ]) }} as id_provincia,
    {{ dbt_utils.generate_surrogate_key([ 'matricula' ]) }} as id_vehiculo,
    {{ dbt_utils.generate_surrogate_key([ 'zona' ]) }} as id_via,
    TO_DATE(data, 'DD/MM/YYYY') AS fecha_accidente,
    matricula,
    victimas_mortales as num_victimas_mortales,
    resultado_toxicoloxico as test_toxicologico,
    {{ dbt_utils.generate_surrogate_key(['Etanol', 'Drogas']) }} as id_motivo
    from accidentes
)

select * from valores_base

--{% if is_incremental() %}

--  where fecha_accidente > (select max(fecha_accidente) from {{ this }})

--{% endif %}