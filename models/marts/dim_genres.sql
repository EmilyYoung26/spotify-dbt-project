with base as (

  select distinct
    genre
  from {{ ref('int_tracks_enriched') }}
  where genre is not null

)

select
  {{ dbt_utils.generate_surrogate_key(['genre']) }} as genre_id,
  genre
from base 