with base as(

  select distinct
    album_name
  from {{ ref('int_track_deduped_enriched') }}
  where album_name is not null

)

select
  album_name
from base
