-- identifying gaps in missing years for each genre with LAG()
WITH genre_years as(
    SELECT *,
        LAG(release_year) OVER(PARTITION BY artist_genres ORDER BY release_year) as previous_year
    FROM market_share_filtered
),
year_gap as(
    SELECT *,
        release_year - previous_year as year_gap
    FROM genre_years
),
-- storing all metrics & lagged metrics
previous_metrics as(
    SELECT *,
        LAG(market_share) OVER(PARTITION BY artist_genres ORDER BY release_year) as previous_market_share,
        LAG(avg_popularity) OVER(PARTITION BY artist_genres ORDER BY release_year) as previous_avg_popularity,
        LAG(hit_share) OVER(PARTITION BY artist_genres ORDER BY release_year) as previous_hit_share,
        LAG(genre_rank) OVER(PARTITION BY artist_genres ORDER BY release_year) as previous_genre_rank
    from year_gap
)
/* calculating market change metrics
the goal is to calculate metrics for consecutive years (year_gap = 1)*/
SELECT
    artist_genres,
    release_year,
    year_gap,
    market_share,
    avg_popularity,
    hit_share,
    genre_rank,
    weighted_tracks,
    (CASE WHEN year_gap = 1 THEN (market_share - previous_market_share)*100 -- needs to be in percentage points
    ELSE NULL END) as market_share_change,
    (CASE WHEN year_gap = 1 THEN avg_popularity - previous_avg_popularity
    ELSE NULL END) as avg_popularity_change,
    (CASE WHEN year_gap = 1 THEN (hit_share - previous_hit_share)*100 -- needs to be in percentage points
    ELSE NULL END) as hit_share_change,
    (CASE WHEN year_gap = 1 THEN previous_genre_rank - genre_rank 
    ELSE NULL END) as genre_rank_change
FROM previous_metrics
ORDER BY artist_genres, release_year

