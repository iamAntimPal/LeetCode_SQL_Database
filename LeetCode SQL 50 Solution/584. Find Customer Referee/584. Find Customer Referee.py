import pandas as pd

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    # Filter rows where referee_id is not equal to 2 or is null
    result = customer[(customer['referee_id'] != 2) | (customer['referee_id'].isnull())][['name']]
    return result