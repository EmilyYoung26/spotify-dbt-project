with intermediate_pairs as (

  select distinct
    track_id,
    artist_name
  from {{ ref('int_track_artists') }}

),

mart_pairs as (

  select distinct
    track_id,
    artist_name
  from {{ ref('fact_track_artist_metrics') }}

),

missing_from_mart as (

  select *
  from intermediate_pairs
  except distinct
  select *
  from mart_pairs

),

extra_in_mart as (

  select *
  from mart_pairs
  except distinct
  select *
  from intermediate_pairs

)

select * from missing_from_mart
union all
select * from extra_in_mart

--this improved version (old one in notes app) not only counts the match but that the actual pairs match exactly. 