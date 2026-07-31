select *
from {{ ref('scd_silver_airports') }}
where airport_ident = '01CN'
order by dbt_valid_from
