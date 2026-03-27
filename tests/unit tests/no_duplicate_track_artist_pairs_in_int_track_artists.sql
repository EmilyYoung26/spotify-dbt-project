select
  track_id,
  artist_name,
  count(*) as row_count
from {{ ref('int_track_artists') }}
group by 1, 2
having count(*) > 1
