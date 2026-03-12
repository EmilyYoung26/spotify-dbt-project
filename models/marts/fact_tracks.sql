with tracks as (
  
  select *
  from {{ ref('int_tracks_enriched') }}

),

final as (

  select 
    t.track_id, 
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

)

select * from final