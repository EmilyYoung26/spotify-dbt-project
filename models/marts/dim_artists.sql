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

canonical as (

  select
    artist_name, 
    lower(trim(artist_name)) as artist_key -- this is the cannonical matching key to prevent join fan out. 
  from split_artists
  where artist_name != ''

),

deduped as (

  select 
    artist_key, 
    any_value(artist_name) as artist_name
  from canonical
  group by artist_key

)

select 
  {{ dbt_utils.generate_surrogate_key(['artist_key']) }} as artist_id,
  artist_name, artist_key
from deduped 

------------- NOTES -------------

-- trim removes any extra spaces 
-- unnest turns the array into multiple rows 
-- split(artists, ';') turns artist 1;artist 2 into artist 1, artist 2