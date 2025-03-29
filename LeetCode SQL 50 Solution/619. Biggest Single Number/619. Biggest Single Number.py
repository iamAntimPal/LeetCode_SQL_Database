import pandas as pd

def biggest_single_number(my_numbers: pd.DataFrame) -> pd.DataFrame:
    # Group by 'num' and filter those numbers that appear exactly once
    unique_numbers = my_numbers.groupby('num').filter(lambda group: len(group) == 1)
    
    # Determine the largest single number, if any
    if unique_numbers.empty:
        result = None
    else:
        result = unique_numbers['num'].max()
    
    return pd.DataFrame({'num': [result]})
