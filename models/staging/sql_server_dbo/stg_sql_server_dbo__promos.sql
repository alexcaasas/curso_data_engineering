{{
    config(
        materialized='view'
    )
}}

with todas_promos as (
    select *
    from {{ source ('sql_server_dbo', 'promos') }}
),

limpio_promos as (
    select 
    md5(promo_id) as promo_id,
    promo_id as promo_name,
    discount as dolar_discount,
    status as status,
    _fivetran_deleted as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC', _fivetran_synced) as _fivetran_synced_utc
    from todas_promos

    union all

    select 
    md5('NO PROMO') as promo_id,
    'NO PROMO' as promo_name,
    0 as dolar_discount,
    'inactive' as status,
    null as _fivetran_deleted,
    CONVERT_TIMEZONE('UTC', '2000-10-25 18:00:37.597 +0200') as _fivetran_synced_utc
)

select * from limpio_promos