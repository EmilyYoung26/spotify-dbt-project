with tracks as (
  
  select *
  from {{ ref('int_tracks_enriched') }}

),

artists as (

  select
    artist_key,
    any_value(artist_id) as artist_id
  from {{ ref('dim_artists') }}
  group by artist_key

),

genres as (

  select
    genre,
    any_value(genre_id) as genre_id
  from {{ ref('dim_genres') }}
  group by genre

),

albums as (

  select
    album_key,
    any_value(album_id) as album_id
  from {{ ref('dim_albums') }}
  group by album_key

),

final as (

  select 
    t.track_id, 

    -- below is the foreign keys for relationship tests
    a.artist_id,
    g.genre_id,
    al.album_id,

    -- keep natural keys too (for debugging)
    t.artists,
    t.genre,
    t.track_name,
    t.album_name, 

    -- below is our measurements
    t.popularity, 
    t.duration_minutes,
    t.danceability,
    t.energy,
    t.tempo,

    -- below is our buckets 
    t.popularity_bucket,
    t.duration_bucket,
    t.danceability_bucket,
    t.energy_bucket,
    t.tempo_bucket

  from tracks as t

  -- the artist join below (is a map to "primary artist" which is the first artist in the ';' separated list)
  left join artists as a
    on a.artist_key = lower(trim(split(coalesce(t.artists, ''), ';')[safe_offset(0)]))

  left join genres as g 
    on lower(trim(g.genre)) = lower(trim(t.genre))

  left join albums as al
    on al.album_key = coalesce(lower(trim(nullif(t.album_name, ''))), 'unknown')
)

select * from final