with base as (

    select 
      album_name
    from {{ ref('int_tracks_enriched') }}
    where album_name is not null 
      and trim(album_name) != ''

), 

canonical as (

  select
    album_name,
    lower(trim(album_name)) as album_key
  from base

),

deduped as (

  select
    album_key,
    any_value(album_name) as album_name
  from canonical
  group by album_key

),

unknown_row as (

  select
    'unknown' as album_key,
    'Unknown Album' as album_name

)

select
  {{ dbt_utils.generate_surrogate_key(['album_key']) }} as album_id,
  album_name,
  album_key
from (
  select * from deduped
  union all
  select * from unknown_row
)