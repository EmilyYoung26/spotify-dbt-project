with tracks as (
  
  select *
  from {{ ref('int_tracks_enriched') }}

),

artists as (

  select artist_id, artist_name, artist_key
  from {{ ref('dim_artists') }}

),

genres as (

  select genre_id, genre
  from {{ ref('dim_genres') }}

),

final as (

  select 
    t.track_id, 

    -- below is the foreign keys for relationship tests
    a.artist_id,
    g.genre_id,

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

)

select * from final