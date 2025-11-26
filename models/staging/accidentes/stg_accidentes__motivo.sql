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
CASE 
    WHEN Etanol = '+' AND Drogas = '+' AND Antidepresivos = '+' THEN 'Alcohol, Drogas y Antidepresivos'
    WHEN Etanol = '+' AND Drogas = '-' AND Antidepresivos = '+' THEN 'Alcohol y Antidepresivos'
    WHEN Etanol = '-' AND Drogas = '+' AND Antidepresivos = '+' THEN 'Drogas y Antidepresivos'
    WHEN Etanol = '-' AND Drogas = '-' AND Antidepresivos = '+' THEN 'Antidepresivos'

    WHEN Etanol = '+' AND Drogas = '+' AND Antidepresivos = '-' THEN 'Alcohol y Drogas'
    WHEN Etanol = '+' AND Drogas = '-' AND Antidepresivos = '-' THEN 'Alcohol'
    WHEN Etanol = '-' AND Drogas = '+' AND Antidepresivos = '-' THEN 'Drogas'
    WHEN Etanol = '-' AND Drogas = '-' AND Antidepresivos = '-' THEN 'Limpio'
END AS motivos
*/

select * from motivos