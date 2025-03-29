import pandas as pd

def delete_duplicate_emails(person: pd.DataFrame) -> None:
    # Keep only the first occurrence of each email (smallest id)
    person.drop_duplicates(subset=['email'], keep='first', inplace=True)