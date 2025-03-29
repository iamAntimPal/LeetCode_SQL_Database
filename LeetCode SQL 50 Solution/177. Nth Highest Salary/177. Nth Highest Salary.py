import pandas as pd

def getNthHighestSalary(employee: pd.DataFrame, N: int) -> pd.DataFrame:
    unique_salaries = employee['salary'].drop_duplicates().nlargest(N)
    if len(unique_salaries) < N:
        return pd.DataFrame({"getNthHighestSalary(N)": [None]})
    return pd.DataFrame({"getNthHighestSalary(N)": [unique_salaries.iloc[-1]]})