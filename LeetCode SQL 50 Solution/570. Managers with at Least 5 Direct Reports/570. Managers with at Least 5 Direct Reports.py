import pandas as pd

def managers_with_five_reports(employee: pd.DataFrame) -> None:
    # Count direct reports for each manager
    report_counts = employee.groupby('managerId').size().reset_index(name='report_count')
    
    # Identify managerIds with at least five direct reports
    valid_managers = report_counts[report_counts['report_count'] >= 5]['managerId']
    
    # Filter the Employee table to get manager names
    # Note: Since managerId can be null, we ignore them during merge.
    result = employee[employee['id'].isin(valid_managers)][['name']]
    
    # Modify the original DataFrame in place if required.
    employee = result
    print(result)