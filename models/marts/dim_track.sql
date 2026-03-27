with tracks as (

    select *
    from {{ ref('int_track_deduped_enriched') }}

)

select
  track_id, 
  track_name,
  album_name,
  genre, 
  duration_minutes,
  duration_bucket
from tracks