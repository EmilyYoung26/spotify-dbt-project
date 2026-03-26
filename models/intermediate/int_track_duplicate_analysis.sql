with tracks as (

    select *
    from {{ ref('stg_spotify_tracks') }}

), 

duplicates as (

    select
      track_id, 
      count(*) as row_count
    from tracks
    group by 1
    having count(*) > 1

)

select * from duplicates