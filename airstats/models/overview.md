{% docs __overview__ %}

# AirStats

This project transforms global airport data from [OurAirports.com](https://ourairports.com/data/) into an
analytics-ready silver layer on Snowflake.

## How the silver tables interconnect

`silver_airports` is the hub: each row is one airport, keyed by `airport_ident` (its ICAO code). The other two
silver tables hang off it via that same `airport_ident` column — `silver_runways` holds one row per physical
runway belonging to an airport, and `silver_airport_comments` holds user-submitted comments about an airport.
Neither `silver_runways` nor `silver_airport_comments` is meaningful on its own; both exist to be joined back to
`silver_airports` to answer questions like "which runways does this airport have" or "what have users said about
this airport." Referential integrity between them is validated with `relationships` tests, set to `warn` rather
than `error` since the open-data source doesn't guarantee every comment or runway points to a currently-known
airport.

{% enddocs %}

{% docs airport_ident %}

The ICAO airport code (e.g. `KLAX`, `EGLL`). This is the natural key connecting all three silver tables:
`silver_airports` is the authoritative registry of airports, while `silver_runways` and `silver_airport_comments`
each reference an airport through this column.

{% enddocs %}
