{{
    config(
        materialized='view'
    )
}}

with accidentes as (
    select *
    from {{ source ('desarrollo', 'accidentes_final') }}
),

limpieza_base as (
    select 
        {{ dbt_utils.generate_surrogate_key([ 'dni','provincia', 'matricula', 'zona', 'data']) }} as id_accidente,
        {{ dbt_utils.generate_surrogate_key([ 'sexo' ]) }} as id_sexo,
        {{ dbt_utils.generate_surrogate_key([ 'matricula' ]) }} as id_vehiculo,
        {{ dbt_utils.generate_surrogate_key([ 'tipo_vehiculo' ]) }} as id_tipo_vehiculo,
        {{ dbt_utils.generate_surrogate_key([ 'provincia' ]) }} as id_provincia,
        {{ dbt_utils.generate_surrogate_key([ 'ccaa' ]) }} as id_com_autonoma,
        {{ dbt_utils.generate_surrogate_key([ 'dni' ]) }} as id_conductor,
        {{ dbt_utils.generate_surrogate_key([ 'rango_de_edade' ]) }} as id_rango_edades,
        {{ dbt_utils.generate_surrogate_key([ 'zona' ]) }} as id_via,
        {{ dbt_utils.generate_surrogate_key(['Etanol', 'Drogas', 'Antidepresivos' ]) }} as id_motivo,
        {{ motivo_toxicologico (["Etanol", "Drogas", "Antidepresivos"]) }} as motivo,
        dni,
        matricula,
        data,
        sexo,
        provincia,
        ccaa,
        rango_de_edade,
        tipo_vehiculo,
        zona,
        etanol,
        drogas,
        cocaina, 
        antidepresivos,
        cannabis,
        opiaceos,
        opioides,
        victimas_mortales,
        victimas_toxic_positivo,
        resultado_toxicoloxico,
        ano, 
        organismo,
        rol_no_siniestro,
        psicofarmacos,
        antiepilepticos,
        fecha_ingesta
    from accidentes
)

select * from limpieza_base