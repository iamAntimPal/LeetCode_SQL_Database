Below is a complete Python solution using a class with methods to solve the problem with Pandas. This code creates the data (mimicking the SQL tables), then provides methods to run each query.

```python
import pandas as pd

class ProsnalDatabase:
    def __init__(self):
        # Create tables (as Pandas DataFrames)
        self.create_tables()

    def create_tables(self):
        # Employees Table
        self.employees = pd.DataFrame({
            'Id': [1, 2, 3, 4, 5],
            'Name': ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Black', 'David White'],
            'Salary': [50000, 60000, 70000, 60000, 70000],
            'Department': ['HR', 'Finance', 'IT', 'Finance', 'IT']
        })

        # Projects Table
        self.projects = pd.DataFrame({
            'Id': [1, 2, 3],
            'Name': ['Project A', 'Project B', 'Project C'],
            'Department': ['IT', 'Finance', 'IT']
        })

        # EmployeeProjects Table
        self.employee_projects = pd.DataFrame({
            'EmployeeId': [1, 1, 2, 3, 3, 4, 5],
            'ProjectId': [1, 2, 1, 1, 3, 2, 1]
        })

        # Users Table
        self.users = pd.DataFrame({
            'id': [1, 2],
            'name': ['John Doe', 'Jane Smith'],
            'email': ['john.doe@example.com', 'antima@example.com']
        })

        # Sessions Table
        self.sessions = pd.DataFrame({
            'id': [1, 2, 3],
            'user_id': [1, 1, 2],
            'session_date': pd.to_datetime(['2022-01-01', '2022-01-02', '2022-01-03'])
        })

        # Products Table
        self.products = pd.DataFrame({
            'id': [1, 2, 3],
            'name': ['Product A', 'Product B', 'Product C'],
            'price': [10.99, 20.99, 30.99]
        })

        # Orders Table
        self.orders = pd.DataFrame({
            'id': [1, 2, 3, 4, 5],
            'product_id': [1, 2, 3, 1, 2],
            'quantity': [5, 3, 1, 2, 4]
        })

    def query_employee_projects(self):
        """
        Returns a DataFrame that lists each employee's project details.
        This joins the Employees, EmployeeProjects, and Projects DataFrames.
        """
        # Merge Employees with EmployeeProjects
        emp_proj = self.employees.merge(
            self.employee_projects, left_on='Id', right_on='EmployeeId'
        )
        # Merge with Projects to get project details
        emp_proj = emp_proj.merge(
            self.projects, left_on='ProjectId', right_on='Id', suffixes=('_Employee', '_Project')
        )
        # Select and rename desired columns
        result = emp_proj[['Name_Employee', 'Department_Employee', 'Name_Project', 'Department_Project']]
        result = result.rename(columns={
            'Name_Employee': 'EmployeeName',
            'Department_Employee': 'EmployeeDepartment',
            'Name_Project': 'ProjectName',
            'Department_Project': 'ProjectDepartment'
        })
        return result

    def query_user_sessions(self):
        """
        Returns a DataFrame that lists the session dates for each user.
        This joins the Users and Sessions DataFrames.
        """
        user_sessions = self.users.merge(
            self.sessions, left_on='id', right_on='user_id'
        )
        result = user_sessions[['name', 'session_date']].rename(columns={'name': 'user_name'})
        return result

    def query_order_totals(self):
        """
        Returns a DataFrame that calculates the total price for each order.
        This joins the Products and Orders DataFrames and computes total price = price * quantity.
        """
        orders_merged = self.orders.merge(
            self.products, left_on='product_id', right_on='id'
        )
        orders_merged['total_price'] = orders_merged['price'] * orders_merged['quantity']
        result = orders_merged[['name', 'quantity', 'total_price']].rename(columns={'name': 'product_name'})
        return result

# Example usage:
if __name__ == '__main__':
    db = ProsnalDatabase()
    
    print("Employee Projects:")
    print(db.query_employee_projects(), "\n")
    
    print("User Sessions:")
    print(db.query_user_sessions(), "\n")
    
    print("Order Totals:")
    print(db.query_order_totals())
```

### Explanation:
- **Class Initialization (`__init__`)**:  
  The `ProsnalDatabase` class initializes by calling `create_tables()`, which creates sample DataFrames for all tables.
  
- **`create_tables()`**:  
  This method creates DataFrames for `Employees`, `Projects`, `EmployeeProjects`, `Users`, `Sessions`, `Products`, and `Orders` with sample data.
  
- **Query Methods**:
  - **`query_employee_projects()`**:  
    Merges the `employees`, `employee_projects`, and `projects` DataFrames to show which employee works on which project. Columns are renamed for clarity.
    
  - **`query_user_sessions()`**:  
    Merges the `users` and `sessions` DataFrames to list session dates for each user.
    
  - **`query_order_totals()`**:  
    Merges the `orders` DataFrame with the `products` DataFrame and calculates the total price for each order.

- **Main Block**:  
  An instance of `ProsnalDatabase` is created, and the query methods are executed to display results.

This modular, class-based approach using Pandas helps encapsulate data and query logic in a single, easy-to-manage unit. Let me know if you need any further modifications!