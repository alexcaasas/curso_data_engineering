{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

uniendo_sexo as (
    select
    distinct {{ dbt_utils.generate_surrogate_key([ 'sexo' ]) }} as id_sexo,
    sexo,
    from accidentes 
)

select * from uniendo_sexo