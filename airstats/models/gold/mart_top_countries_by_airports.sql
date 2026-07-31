with airports as (

    select * from {{ ref('silver_airports') }}

),

by_country as (

    select
        iso_country,
        count(*) as airport_count

    from airports
    group by iso_country

)

select
    iso_country,
    airport_count,
    row_number() over (order by airport_count desc, iso_country asc) as rank

from by_country
qualify rank <= 10
order by airport_count desc
