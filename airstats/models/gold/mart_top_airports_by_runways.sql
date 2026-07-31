with airports as (

    select * from {{ ref('silver_airports') }}

),

runways as (

    select * from {{ ref('silver_runways') }}

),

runway_counts as (

    select
        airport_ident,
        count(*) as runway_count

    from runways
    group by airport_ident

)

select
    airports.airport_ident,
    airports.airport_name,
    airports.iso_country,
    runway_counts.runway_count,
    row_number() over (order by runway_counts.runway_count desc, airports.airport_ident asc) as rank

from runway_counts
inner join airports on airports.airport_ident = runway_counts.airport_ident
qualify rank <= 10
order by runway_counts.runway_count desc
