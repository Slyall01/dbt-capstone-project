{{ config(materialized='incremental') }}

with source as (

    select * from {{ ref('src_airport_comments') }}

),

filtered as (

    select
        comment_id,
        airport_ident,
        comment_timestamp,
        case
            when member_nickname is null then '__UNKNOWN__'
            else member_nickname
        end as member_nickname,
        comment_subject,
        comment_body,
        current_timestamp() as loaded_at

    from source
    where comment_body is not null and trim(comment_body) != ''

)

select * from filtered

{% if is_incremental() %}

where comment_id > (select max(comment_id) from {{ this }})

{% endif %}
