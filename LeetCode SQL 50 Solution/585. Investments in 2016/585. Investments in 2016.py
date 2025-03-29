import pandas as pd

def investments_in_2016(insurance: pd.DataFrame) -> pd.DataFrame:
    # Count the number of occurrences for each tiv_2015 value
    insurance['tiv_2015_count'] = insurance.groupby('tiv_2015')['tiv_2015'].transform('count')
    
    # Count the number of occurrences for each (lat, lon) pair
    insurance['city_count'] = insurance.groupby(['lat', 'lon'])['lat'].transform('count')
    
    # Filter rows that meet both criteria:
    # 1. tiv_2015 appears more than once.
    # 2. The location (lat, lon) is unique (appears only once).
    valid_rows = insurance[(insurance['tiv_2015_count'] > 1) & (insurance['city_count'] == 1)]
    
    # Calculate the sum of tiv_2016 and round to 2 decimal places
    total_tiv_2016 = round(valid_rows['tiv_2016'].sum(), 2)
    
    # Return result as a DataFrame
    return pd.DataFrame({'tiv_2016': [total_tiv_2016]})