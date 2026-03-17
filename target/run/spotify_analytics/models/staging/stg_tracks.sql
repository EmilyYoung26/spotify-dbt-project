

  create or replace view `emilys-analytics`.`spotify_analytics`.`stg_tracks`
  OPTIONS()
  as with source as (
    select *
    from `emilys-analytics`.`spotify_analytics`.`raw_spotify_tracks`

),

ranked as (
  select *, 
    row_number() over (
      partition by track_id
      order by popularity desc nulls last, track_name asc
    ) as rn
  from source
),

deduped as (
  select *
  from ranked
  where rn = 1 
),

cleaned as ( -- This is also know as 'renamed as'.
    
  select -- keeping our string values in a chunk together.
    cast(track_id as string) as track_id,
    cast(track_name as string) as track_name,
    cast(artists as string) as artists,
    cast(album_name as string) as album_name,

    -- next we need to make lowercase and trim.
    lower(trim(cast(track_genre as string))) as genre,

    -- next we keep any int64 values together. 
    cast(popularity as int64) as popularity,
    cast(duration_ms as int64) as duration_ms,

    -- keep our float64 values together. 
    cast(danceability as float64) as danceability,
    cast(energy as float64) as energy,
    cast(tempo as float64) as tempo

  from deduped
),

final as (

  select
    track_id,
    track_name,
    artists,
    album_name,
    genre,
    popularity,
    danceability,
    energy,
    tempo,
    duration_ms,

    
  safe_divide(cast(duration_ms as float64), 60000)
 as duration_minutes

    from cleaned
)

select * from final;

