with base as (

    select
        genre,
        artist_name,
        sum(popularity) as total_popularity
    
    from {{ ref('fact_track_artist_metric') }}
    where genre is not null
    group by 1, 2

),

ranked as (

    select
        genre,
        artist_name,
        total_popularity,
        row_number() over (
            partition by genre
            order by total_popularity desc
        ) as rank_in_genre
    from base

)

select *
from ranked
where rank_in_genre <= 3