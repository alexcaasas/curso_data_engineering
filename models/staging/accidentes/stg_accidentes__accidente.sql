{{
    config(
        materialized='table'
    )
}}
with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

provincias as (
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

tipos_vias as (
    select id_via
    from {{ ref ('stg_accidentes__tipo_via')}}
),

valores_base as (
    select 
    {{ dbt_utils.generate_surrogate_key([ 'dni' ]) }} as id_conductor,
    {{ dbt_utils.generate_surrogate_key([ 'provincia' ]) }} as id_provincia,
    {{ dbt_utils.generate_surrogate_key([ 'matricula' ]) }} as id_vehiculo,
    {{ dbt_utils.generate_surrogate_key([ 'zona' ]) }} as id_via,
    TO_DATE(data, 'DD/MM/YYYY') AS fecha_accidente,
    victimas_mortales as num_victimas_mortales,
    resultado_toxicoloxico as test_toxicologico,
    dni,
    {{ dbt_utils.generate_surrogate_key(['Etanol', 'Drogas']) }} as id_motivo,
    from accidentes
),

uno_todo as (
    select 
        {{ dbt_utils.generate_surrogate_key([ 'c.id_conductor', 'p.id_provincia', 'v.id_vehiculo', 'vi.id_via', 'm.id_motivo' ]) }} as id_accidente,
        c.id_conductor,
        p.id_provincia,
        v.id_vehiculo,
        vi.id_via,
        b.fecha_accidente,
        b.dni,
        b.num_victimas_mortales,
        b.test_toxicologico,
        m.id_motivo
    from valores_base b
    left join provincias p 
        on p.id_provincia = b.id_provincia
    left join conductores c
        on c.id_conductor = b.id_conductor
    left join vehiculos v
        on v.id_vehiculo = b.id_vehiculo
    left join motivos m
        on m.id_motivo = b.id_motivo
    left join tipos_vias vi 
        on vi.id_via = b.id_via
)

select * from uno_todo

--{% if is_incremental() %}

--  where fecha_accidente > (select max(fecha_accidente) from {{ this }})

--{% endif %}