import pandas as pd

def exchange_seats(seat: pd.DataFrame) -> pd.DataFrame:
    # Total number of students
    total = seat.shape[0]
    
    # Function to compute the new seat id
    def new_id(row):
        # For odd id values:
        if row['id'] % 2 != 0:
            # If it's the last row in an odd-length list, do not change the id.
            if row['id'] == total:
                return row['id']
            else:
                return row['id'] + 1
        # For even id values, swap with previous odd id
        else:
            return row['id'] - 1