import pandas as pd

def not_boring_movies(cinema: pd.DataFrame) -> pd.DataFrame:
    # Filter movies with odd-numbered id and description not equal to 'boring'
    result = cinema[(cinema['id'] % 2 == 1) & (cinema['description'] != 'boring')]
    # Sort the result by rating in descending order
    return result.sort_values(by='rating', ascending=False)
