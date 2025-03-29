import pandas as pd

def triangle_judgement(triangle: pd.DataFrame) -> pd.DataFrame:
    # Create a new column 'triangle' based on the triangle inequality conditions
    triangle['triangle'] = triangle.apply(
        lambda row: 'Yes' if (row['x'] + row['y'] > row['z'] and 
                              row['x'] + row['z'] > row['y'] and 
                              row['y'] + row['z'] > row['x']) else 'No',
        axis=1
    )
    return triangle