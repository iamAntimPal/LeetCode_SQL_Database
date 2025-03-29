import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    # Filter countries that are considered big by either area or population
    result = world[(world['area'] >= 3000000) | (world['population'] >= 25000000)][['name', 'population', 'area']]
    return result