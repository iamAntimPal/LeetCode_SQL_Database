import pandas as pd

def game_play_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    # Get first login date for each player
    first_login = activity.groupby("player_id")["event_date"].min().reset_index()
    first_login.columns = ["player_id", "first_login"]
    
    # Merge first login date with original table
    merged = activity.merge(first_login, on="player_id")
    
    # Filter players who logged in the next day
    next_day_logins = merged[
        (merged["event_date"] - merged["first_login"]).dt.days == 1
    ]["player_id"].nunique()
    
    # Total unique players
    total_players = activity["player_id"].nunique()
    
    # Calculate fraction
    fraction = round(next_day_logins / total_players, 2)
    
    return pd.DataFrame({"fraction": [fraction]})