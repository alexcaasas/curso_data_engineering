{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ ref('base_source') }}
),

uniendo_com_autonoma as (
    select
    distinct id_com_autonoma,
    CASE 
        WHEN ccaa = 'Canarias' THEN 'Islas Canarias'
        ELSE REPLACE(ccaa, '-', ' ')
    END AS com_autonoma,
    from accidentes 
)

select * from uniendo_com_autonoma