-- average track popularity
WITH avg_popularity AS(
    SELECT
        release_year,
        artist_genres,
        AVG(track_popularity) AS avg_popularity
    FROM spotify_prev
    GROUP BY
        release_year,
        artist_genres
),

-- market share
genre_counts AS(
    SELECT
        release_year,
        artist_genres,
        SUM(genre_weight) AS weighted_tracks
    FROM spotify_prev
    GROUP BY
        release_year,
        artist_genres
),

yearly_totals AS(
    SELECT
        release_year,
        SUM(weighted_tracks) AS total_weighted_tracks
    FROM genre_counts
    GROUP BY release_year
),

genre_market_share AS(
    SELECT
        g.release_year,
        g.artist_genres,
        g.weighted_tracks,
        g.weighted_tracks*1.0/y.total_weighted_tracks AS market_share
    FROM genre_counts g 
    JOIN yearly_totals y
        ON g.release_year = y.release_year
)

-- all metrics & genre rank
SELECT
    g.artist_genres,
    g.release_year,
    g.weighted_tracks,
    g.market_share,
    a.avg_popularity,
    RANK() OVER(PARTITION BY g.release_year ORDER BY g.market_share DESC) AS genre_rank
FROM genre_market_share g
JOIN avg_popularity a
    ON g.release_year = a.release_year
    AND g.artist_genres = a.artist_genres
ORDER BY    
    g.release_year,
    genre_rank;

