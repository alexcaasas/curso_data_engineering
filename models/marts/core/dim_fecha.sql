with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'2023-01-01'",
        end_date="current_date"
    ) }}

),

final as (
    select
        cast(to_char(date_day, 'YYYYMMDD') as varchar) as id_fecha,
        extract(day from date_day)  as dia,
        extract(month from date_day) as mes,
        extract(quarter from date_day) as trimestre,

        case 
            when dayofweek(date_day) in (6, 7) then 'Si'
            else 'No'
        end as finde

    from date_spine
)

select * from final
