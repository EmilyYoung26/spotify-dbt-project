with tracks as (

  select 
    track_id, 
    artists
  from {{ ref('int_tracks_enriched') }}
  where track_id is not null and artists is not null

),

split_artists as (

  select 
    track_id,
    trim(artist) as artist_name
  from tracks,
  unnest(split(artists, ';')) as artist

)

select
  track_id,
  artist_name
from split_artists
where artist_name != ''

