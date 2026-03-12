with base as (

  select
    artists
  from {{ ref('int_tracks_enriched') }}
  where artists is not null

), 

split_artists as (

  select 
    trim(artist) as artist_name
  from base, 
  unnest(split(artists, ';')) as artist

),

final as (

  select distinct 
    artist_name
  from split_artists
  where artist_name != ''

)

select 
  {{ dbt_utils.generate_surrogate_key(['artist_name']) }} as artist_id,
  artist_name
from final 

------------- NOTES -------------

-- trim removes any extra spaces 
-- unnest turns the array into multiple rows 
-- split(artists, ';') turns artist 1;artist 2 into artist 1, artist 2