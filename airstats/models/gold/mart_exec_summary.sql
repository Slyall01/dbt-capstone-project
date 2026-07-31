with airports as (

    select * from {{ ref('silver_airports') }}

),

runways as (

    select * from {{ ref('silver_runways') }}

),

comments as (

    select * from {{ ref('silver_airport_comments') }}

),

airport_stats as (

    select
        count(*) as total_airports,
        count_if(airport_type != 'closed') as total_open_airports,
        count_if(airport_type = 'closed') as total_closed_airports,
        round(100.0 * count_if(airport_scheduled_service = 'yes') / nullif(count(*), 0), 1) as pct_scheduled_service,
        count(distinct iso_country) as countries_represented,
        count(distinct continent) as continents_represented

    from airports

),

runway_stats as (

    select
        count(*) as total_runways,
        round(100.0 * count_if(runway_lighted = 1) / nullif(count(*), 0), 1) as pct_lighted_runways,
        round(avg(runway_length_ft), 0) as avg_runway_length_ft

    from runways

),

comment_stats as (

    select
        count(*) as total_comments

    from comments

)

select
    airport_stats.total_airports,
    airport_stats.total_open_airports,
    airport_stats.total_closed_airports,
    airport_stats.pct_scheduled_service,
    airport_stats.countries_represented,
    airport_stats.continents_represented,
    runway_stats.total_runways,
    runway_stats.pct_lighted_runways,
    runway_stats.avg_runway_length_ft,
    comment_stats.total_comments

from airport_stats
cross join runway_stats
cross join comment_stats
