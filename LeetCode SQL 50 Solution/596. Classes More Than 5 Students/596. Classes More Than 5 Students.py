import pandas as pd

def classes_with_five_or_more_students(courses: pd.DataFrame) -> pd.DataFrame:
    # Group by 'class' and count the number of students
    result = courses.groupby('class').filter(lambda x: len(x) >= 5)
    # Return only the distinct class names
    return result[['class']].drop_duplicates().reset_index(drop=True)