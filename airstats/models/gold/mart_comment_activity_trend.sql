with comments as (

    select * from {{ ref('silver_airport_comments') }}

),

monthly as (

    select
        date_trunc('month', comment_timestamp) as comment_month,
        count(*) as comment_count

    from comments
    group by date_trunc('month', comment_timestamp)

)

select
    comment_month,
    comment_count

from monthly
order by comment_month
