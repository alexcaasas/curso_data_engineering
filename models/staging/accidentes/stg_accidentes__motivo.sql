{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref('base_source') }}
),

motivos as (
    select
    distinct id_motivo,
    motivo
    from accidentes
)

/*
CASE WHEN Etanol = '+' and Drogas = '+' THEN 'Alcohol y Drogas'
        WHEN Etanol = '+' and Drogas = '-' THEN 'Alcohol'
        WHEN Etanol = '-' and Drogas = '+' THEN 'Drogas'
        WHEN Etanol = '-' and Drogas = '-' THEN 'Limpio'
END AS motivos
*/

select * from motivos