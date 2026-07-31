{{ config(materialized='ephemeral') }}

with source as (

    select * from {{ source('airstats', 'airports') }}

),

renamed as (

    select
        ident as airport_ident,
        type as airport_type,
        name as airport_name,
        latitude_deg as airport_lat,
        longitude_deg as airport_long,
        elevation_ft as airport_elevation_ft,
        municipality as airport_municipality,
        scheduled_service as airport_scheduled_service,
        continent,
        iso_country,
        iso_region

    from source

)

select * from renamed
