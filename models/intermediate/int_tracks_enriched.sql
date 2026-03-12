with tracks as (

  select *
  from {{ ref('stg_tracks') }}

),

final as (

  select
    track_id,
    track_name,
    artists,
    album_name,
    genre,

    popularity, 
    case 
      when popularity is null then 'unknown'
      when popularity < 25 then '0-24'
      when popularity < 50 then '25-49'
      when popularity < 75 then '50-74'
      else '75-100'
    end as popularity_bucket,

    duration_ms,
    duration_minutes,
    case 
      when duration_minutes is null then 'unknown'
      when duration_minutes < 2 then '<2 min'
      when duration_minutes < 4 then '2-4 min'
      when duration_minutes < 6 then '4-6 min'
      else '6+ min'
    end as duration_bucket,

    danceability, 
    case 
      when danceability is null then 'unknown'
      when danceability < 0.33 then 'low'
      when danceability < 0.66 then 'medium'
      else 'high'
    end as danceability_bucket,

    energy,
    case 
      when energy is null then 'unknown'
      when energy < 0.33 then 'low'
      when energy < 0.66 then 'medium'
      else 'high'
    end as energy_bucket,

    tempo, 
    case 
      when tempo is null then 'unknown'
      when tempo < 90 then 'slow'
      when tempo < 140 then 'medium'
      else 'fast'
    end as tempo_bucket

  from tracks 

)

select * from final
