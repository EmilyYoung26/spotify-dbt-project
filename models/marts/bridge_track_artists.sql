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
    trim(artist) as artist_name,
    lower(trim(artist)) as artist_key
  from tracks,
  unnest(split(artists, ';')) as artist

), 

artists_dim as (

  select
    artist_id,
    artist_key
  from {{ ref('dim_artists') }}

)

select
  s.track_id,
  a.artist_id
from split_artists as s
left join artists_dim as a
  on s.artist_key = a.artist_key
where s.artist_name != ''
