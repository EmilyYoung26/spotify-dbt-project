with base as (

  select distinct
    genre
  from {{ ref('int_track_deduped_enriched') }}
  where genre is not null

)

select
  genre
from base