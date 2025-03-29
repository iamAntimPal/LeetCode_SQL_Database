### **Pandas Solution**

import pandas as pd

def department_top_three_salaries(employee: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    # Merge employee and department tables
    employee = employee.merge(department, left_on='departmentId', right_on='id', suffixes=('', '_dept'))
    
    # Rank employees' salaries within each department
    employee['rank'] = employee.groupby('departmentId')['salary'].rank(method='dense', ascending=False)
    
    # Filter top 3 salaries in each department
    result = employee[employee['rank'] <= 3][['name_dept', 'name', 'salary']]
    
    # Rename columns to match the expected output
    result.columns = ['Department', 'Employee', 'Salary']
    
    return result