with airports as (

    select * from {{ ref('silver_airports') }}

),

comments as (

    select * from {{ ref('silver_airport_comments') }}

),

comment_counts as (

    select
        airport_ident,
        count(*) as comment_count

    from comments
    group by airport_ident

)

select
    airports.airport_ident,
    airports.airport_name,
    airports.iso_country,
    comment_counts.comment_count,
    row_number() over (order by comment_counts.comment_count desc, airports.airport_ident asc) as rank

from comment_counts
inner join airports on airports.airport_ident = comment_counts.airport_ident
qualify rank <= 10
order by comment_counts.comment_count desc
