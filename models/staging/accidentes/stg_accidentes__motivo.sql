{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

limpio_motivos as (
    select
    CAST(
        CASE WHEN Etanol = '+' THEN TRUE
            ELSE FALSE
        END AS BOOLEAN
    ) AS Etanol,
    CAST(
        CASE WHEN Drogas = '+' THEN TRUE
            ELSE FALSE
        END AS BOOLEAN
    ) AS Drogas    
    from accidentes 
),

motivos as (
    select
    {{ dbt_utils.generate_surrogate_key(['Etanol', 'Drogas']) }} as id_motivo,
    CASE WHEN Etanol = True and Drogas = True THEN 'Alcohol y Drogas'
        WHEN Etanol = True and Drogas = False THEN 'Alcohol'
        WHEN Etanol = False and Drogas = True THEN 'Drogas'
        WHEN Etanol = False and Drogas = False THEN 'Limpio'
    END AS motivo
    from limpio_motivos
),

agrupo_motivos as (
    select id_motivo, motivo
    from motivos
    group by motivo, id_motivo
)


select * from agrupo_motivos