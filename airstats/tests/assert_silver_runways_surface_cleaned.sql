select *
from {{ ref('silver_runways') }}
where runway_surface is null or trim(runway_surface) = ''
