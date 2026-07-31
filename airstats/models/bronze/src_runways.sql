{{ config(materialized='ephemeral') }}

with source as (

    select * from {{ source('airstats', 'runways') }}

),

renamed as (

    select
        id as runway_id,
        airport_ident,
        length_ft as runway_length_ft,
        width_ft as runway_width_ft,
        surface as runway_surface,
        lighted as runway_lighted,
        closed as runway_closed

    from source

)

select * from renamed
