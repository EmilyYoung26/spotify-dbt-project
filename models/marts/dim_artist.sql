with base as (

    select distinct
      artist_name
    from {{ ref('int_track_artists') }}
    where artist_name is not null

)

select
  artist_name
from base