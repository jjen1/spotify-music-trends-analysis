# Spotify Music Market & Success Trends Analysis

## Overview

Music trends are constantly changing, but a genre's market presence does not always tell the full story of how well its tracks are performing.

This project analyzes the Spotify Global Music Dataset to explore how genre presence, track performance, and artist strategy have changed over time. Using Python and SQL, I examine both long-term and recent patterns to better understand:

- Which genres hold the strongest market presence
- How genre relevance changes over time
- Which genres are emerging, stable, or declining
- Whether artist specialization or diversification relates to performance
- How recent market behavior compares with historical patterns

The goal is to turn track-level Spotify data into broader insights about **music market behavior and the factors associated with successful tracks and artists**.

---

## Dataset

This project uses the [Spotify Global Music Dataset](https://www.kaggle.com/datasets/wardabilal/spotify-global-music-dataset-20092025) sourced from Kaggle.

The dataset contains track-level Spotify metadata including:

- Track and artist information
- Artist genre assignments
- Track popularity
- Album and release information
- Track duration

Two datasets are used: a historical dataset containing tracks through 2025 and a separate 2025 dataset used for later comparison and validation.

### Data Considerations

Several data-quality issues required additional preparation before analysis:

- Tracks can be associated with multiple genres.
- Genre values are stored differently between the two datasets.
- Release dates contain multiple date formats.
- Track duration is stored using different units.
- Earlier years contain fewer observations and require sparse-data filtering.
- Some artist information is unstructured, creating limitations for artist-level analysis.

---

# Analysis

## Section 1: Genre Market Dynamics & Lifecycle

### Part I — Genre Market Overview

**Business Question:**  
How has genre presence and performance changed between the historical (2000–2020) and recent (2021–2025) music markets?

Tracks with multiple genres are assigned proportional genre weights to prevent overcounting. For example, a track associated with two genres contributes 0.5 to each rather than being counted twice.

Yearly genre metrics are then created using SQL and Python.

### Key Metrics

- **Weighted Tracks** — Track volume adjusted for multi-genre tracks
- **Market Share** — A genre's share of total weighted tracks within each year
- **Genre Rank** — Yearly ranking based on market share
- **Hit Share** — A genre's share of weighted hit tracks, where hits are defined using the top 25% of track popularity
- **Average / Median Popularity** — Measures overall and typical track performance
- **Popularity Standard Deviation** — Measures how consistently tracks within a genre perform

Sparse years are filtered before analysis to reduce the influence of years with insufficient track representation.

### Historical vs. Recent Analysis

Genre performance is evaluated across two non-overlapping periods:

- **Historical:** 2000–2020
- **Recent:** 2021–2025

The analysis compares:

1. **Overall market change** — How genre presence and track performance have shifted between the two periods
2. **Market leader change** — How the genres reaching the top three in yearly market share have changed over time

This analysis separates **market presence** from **track performance**. A genre can lose market share while maintaining or improving its popularity and hit performance.

---

### Part II — Genre Lifecycle

**Business Question:**  
Which genres are growing, stable, or declining, and how sustainable is their relevance over time?

Yearly metrics from Part I are used to measure longer-term genre trajectories.

### Trend Metrics

- **Popularity Growth** — Change in average track popularity over time
- **Market Growth** — Change in market share over time
- **Hit Growth** — Change in hit share over time
- **Trend Slope** — Overall direction of genre performance
- **Volatility** — How consistently a genre performs over time

Rolling periods are used to reduce the influence of short-term yearly fluctuations.

Genres with sufficient historical observations are classified into lifecycle stages:

- **Emerging** — Overall positive trajectory with increasing market and/or hit presence
- **Stable** — Relatively consistent performance with low trend movement
- **Declining** — Overall negative trajectory with decreasing market and/or hit presence

Statistical thresholds will be used to create data-driven classification cutoffs rather than relying on manually selected values.

---

## Section 2: Artist Positioning & Diversification

**Business Question:**  
How does artist genre specialization or diversification relate to track performance?

Artists will be grouped based on the number of genres associated with their music:

- **Specialists** — Focused on a smaller number of genres
- **Moderately Diversified** — Moderate genre variety
- **Highly Diversified** — Associated with a wider range of genres

### Artist Performance Metrics

- Average track popularity
- Median track popularity
- Maximum track popularity
- Popularity standard deviation
- Hit rate

Artist strategies will also be compared across genre lifecycle stages to explore questions such as:

- Does diversification help artists adapt to changing genre trends?
- Do specialists perform more consistently within established genres?
- Is there a tradeoff between consistency and breakout success?

---

## Section 3: Recent Trend Validation

**Business Question:**  
Do the broader patterns identified in the historical analysis remain consistent in recent Spotify data?

The final section will compare the project's genre and artist findings against recent data to examine:

- Changes in genre dominance
- Lifecycle behavior
- Artist diversification patterns
- Popularity and performance consistency
- Differences between historical and recent market structure

This provides a final check on whether patterns found across the broader dataset continue to describe the current music market.

---

# Strategic Recommendations

The final findings will be translated into practical insights around:

- Genres gaining or losing market relevance
- Genres showing sustainable versus volatile growth
- Differences between market presence and track-level success
- Artist positioning within emerging, stable, and declining genres
- Potential advantages and tradeoffs of genre diversification

Recommendations will be added after the lifecycle, artist strategy, and validation analyses are complete.

---

# Tech Stack

**Languages & Analysis**
- Python
- SQL

**Python Libraries**
- pandas
- NumPy
- Matplotlib
- Seaborn

**Database**
- SQLite

**Development**
- Jupyter Notebook
- Visual Studio Code
- Git / GitHub

---

## Project Status

🚧 **In Progress**

- [x] Data exploration
- [x] Data cleaning and preprocessing
- [x] Genre weighting methodology
- [x] Genre market share and performance metrics
- [x] Historical vs. recent genre analysis
- [ ] Genre lifecycle classification
- [ ] Artist diversification analysis
- [ ] Recent trend validation
- [ ] Final visualizations and strategic recommendations