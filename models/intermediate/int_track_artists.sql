with tracks as (

    select 
      track_id, 
      track_name, 
      artists
    from {{ ref('int_track_deduped_enriched') }}
    where artists is not null

), 

split_artists as (

    select
      track_id,
      track_name, 
      trim(artist) as artist_name
    from tracks, 
    unnest(split(artists, ';')) as artist

), 

final as (

    select distinct
      track_id, 
      track_name, 
      artist_name
    from split_artists
    where artist_name != ''

)

select * from final