with track_metrics as (

    select *
    from {{ ref('int_track_deduped_enriched') }}

), 

track_artists as (

    select *
    from {{ ref('int_track_artists') }}

),

final as (

    select
      ta.track_id,
      ta.artist_name,

      tm.track_name,
      tm.album_name,
      tm.genre,

      tm.popularity,
      tm.duration_minutes,
      tm.danceability,
      tm.energy,
      tm.tempo,

      tm.popularity_bucket,
      tm.duration_bucket,
      tm.danceability_bucket,
      tm.energy_bucket,
      tm.tempo_bucket

    from track_artists as ta
    left join track_metrics as tm
      on ta.track_id = tm.track_id

)

select * from final