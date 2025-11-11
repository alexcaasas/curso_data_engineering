{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes') }}
),

uniendo_com_autonoma as (
    select
    distinct {{ dbt_utils.generate_surrogate_key([ 'ccaa' ]) }} as id_com_autonoma,
    CASE 
        WHEN REPLACE(ccaa, '-', ' ') = 'Canarias' THEN 'Islas Canarias'
        ELSE REPLACE(ccaa, '-', ' ')
    END AS com_autonoma,
    from accidentes 
)

select * from uniendo_com_autonoma