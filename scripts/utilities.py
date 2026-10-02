import pandas as pd

def clean_duration(df):
    """
    converts duration columns into the same time unit of seconds for manageability
    """
    if 'track_duration_min' in df.columns:
        df['track_duration_s'] = df['track_duration_min'] * 60
    elif 'track_duration_ms' in df.columns:
        df['track_duration_s'] = df['track_duration_ms'] / 1000

    df.drop(columns=['track_duration_min', 'track_duration_ms'], 
            errors = 'ignore', 
            inplace = True)
    return df

def sort_columns(df):
    """
    sorts column for readability
    """
    df = df.reindex(
        columns=[
            'track_id', 
            'track_name', 
            'track_number', 
            'track_popularity',
            'track_duration_s',
            'explicit',
            'artist_name',
            'artist_popularity',
            'artist_followers',
            'artist_genres',
            'album_id',
            'album_name',
            'album_release_date',
            'album_type',
            'album_total_tracks'])
    return df

def convert_dtypes(df):
    """
    converts specific columns to their respective data type
    """
    df = df.astype({
        'track_number': 'Int64',
        'artist_followers': 'Int64',
        'album_total_tracks': 'Int64',
        'track_popularity': 'float',
        'artist_popularity': 'float'
        })
    
    # 'album_release_date' specific cleaning
    df['album_release_date'] = df['album_release_date'].astype(str).str.strip() 
    df['album_release_date'] = df['album_release_date'].replace('0000', pd.NA)
    format4 = df['album_release_date'].str.len() == 4
    format7 = df['album_release_date'].str.len() == 7

    df.loc[format4, 'album_release_date'] += '-01-01'
    df.loc[format7, 'album_release_date'] += '-01'   

    df['album_release_date'] = pd.to_datetime(df['album_release_date'])
    return df

def clean_data(df):
    """
    wraps all standard data cleaning into one function
    """
    df = clean_duration(df)
    df = sort_columns(df)
    df = convert_dtypes(df)
    return df

def clean_stringified_list(df, col):
    """
    cleans the 'artist_genres' column for the spotify_prev df
    """
    df = df.copy()
    df[col] = (
        df[col]
        .fillna("")
        .astype(str)
        .str.strip("[]")
        .str.replace("'", "")
        .str.split(", ")
    )

    return df

def clean_comma_separated(df, col):
    """
    cleans the 'artist_genres' column for the spotify_2025 df
    """
    df = df.copy()
    df[col] = (
        df[col]
        .fillna("")
        .astype(str)
        .str.split(", ")
    )

    return df