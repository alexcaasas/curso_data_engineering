{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

motivos as (
    select
    {{ dbt_utils.generate_surrogate_key(['Etanol', 'Drogas']) }} as id_motivo,
    CASE WHEN Etanol = '+' and Drogas = '+' THEN 'Alcohol y Drogas'
        WHEN Etanol = '+' and Drogas = '-' THEN 'Alcohol'
        WHEN Etanol = '-' and Drogas = '+' THEN 'Drogas'
        WHEN Etanol = '-' and Drogas = '-' THEN 'Limpio'
    END AS motivo
    from accidentes
),

agrupo_motivos as (
    select id_motivo, motivo
    from motivos
    group by motivo, id_motivo
)


select * from agrupo_motivos