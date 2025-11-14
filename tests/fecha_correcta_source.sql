select *
from {{ source ('desarrollo', 'accidentes_final') }}
where not regexp_like(data, '^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$')