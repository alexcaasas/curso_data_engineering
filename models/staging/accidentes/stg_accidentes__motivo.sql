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
    distinct {{ dbt_utils.generate_surrogate_key(["Etanol", "Drogas"]) }} as id_motivo,
    {{ motivo_toxicologico(["Etanol", "Drogas"]) }} as motivos
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