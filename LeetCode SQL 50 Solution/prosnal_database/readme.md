
# Prosnal Database Example

This repository contains SQL scripts for creating and populating a sample database called `prosnal_database`. The database includes multiple tables and queries demonstrating joins and calculations. The following sections describe the database schema, sample data insertion, and example queries.

---

## Database and Tables

### 1. Create and Use Database
```sql
CREATE DATABASE IF NOT EXISTS prosnal_database;
USE prosnal_database;
```
- This command creates the database `prosnal_database` if it does not exist and sets it as the current working database.

---

### 2. Employees Table
```sql
CREATE TABLE IF NOT EXISTS Employees (
    Id INT,
    Name VARCHAR(255),
    Salary INT,
    Department VARCHAR(255)
);
```
- **Description:**  
  Contains employee information such as `Id`, `Name`, `Salary`, and `Department`.

#### Sample Data:
```sql
INSERT INTO Employees (Id, Name, Salary, Department)
VALUES (1, 'John Doe', 50000, 'HR'),
       (2, 'Jane Smith', 60000, 'Finance'),
       (3, 'Mike Johnson', 70000, 'IT'),
       (4, 'Sarah Black', 60000, 'Finance'),
       (5, 'David White', 70000, 'IT');
```

---

### 3. Projects Table
```sql
CREATE TABLE IF NOT EXISTS Projects (
    Id INT,
    Name VARCHAR(255),
    Department VARCHAR(255)
);
```
- **Description:**  
  Contains project details including project `Id`, `Name`, and the corresponding `Department`.

#### Sample Data:
```sql
INSERT INTO Projects (Id, Name, Department)
VALUES (1, 'Project A', 'IT'),
       (2, 'Project B', 'Finance'),
       (3, 'Project C', 'IT');
```

---

### 4. EmployeeProjects Table
```sql
CREATE TABLE IF NOT EXISTS EmployeeProjects (
    EmployeeId INT,
    ProjectId INT
);
```
- **Description:**  
  Associates employees with projects.

#### Sample Data:
```sql
INSERT INTO EmployeeProjects (EmployeeId, ProjectId)
VALUES (1, 1),
       (1, 2),
       (2, 1),
       (3, 1),
       (3, 3),
       (4, 2),
       (5, 1);
```

---

### 5. Users and Sessions Tables
#### Users Table
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);
```
- **Description:**  
  Contains user information with unique `id`, `name`, and `email`.

#### Sample Data:
```sql
INSERT INTO users (id, name, email)
VALUES (1, 'John Doe', 'john.doe@example.com'),
       (2, 'Jane Smith', 'antima@example.com');
```

#### Sessions Table
```sql
CREATE TABLE sessions (
    id INT PRIMARY KEY,
    user_id INT,
    session_date DATE
);
```
- **Description:**  
  Records session data with session `id`, associated `user_id`, and the `session_date`.

#### Sample Data:
```sql
INSERT INTO sessions (id, user_id, session_date)
VALUES (1, 1, '2022-01-01'),
       (2, 1, '2022-01-02'),
       (3, 2, '2022-01-03');
```

---

### 6. Products and Orders Tables
#### Products Table
```sql
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10, 2)
);
```
- **Description:**  
  Contains product details such as `id`, `name`, and `price`.

#### Sample Data:
```sql
INSERT INTO products (id, name, price)
VALUES (1, 'Product A', 10.99),
       (2, 'Product B', 20.99),
       (3, 'Product C', 30.99);
```

#### Orders Table
```sql
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);
```
- **Description:**  
  Stores order details including order `id`, associated `product_id`, and order `quantity`.

#### Sample Data:
```sql
INSERT INTO orders (id, product_id, quantity)
VALUES (1, 1, 5),
       (2, 2, 3),
       (3, 3, 1),
       (4, 1, 2),
       (5, 2, 4);
```

---

## Example Queries

### Query 1: List Employee Projects
Join the **Employees**, **EmployeeProjects**, and **Projects** tables to list each employee's project details.
```sql
SELECT e.Name AS EmployeeName, e.Department, p.Name AS ProjectName, p.Department
FROM Employees e
JOIN EmployeeProjects ep ON e.Id = ep.EmployeeId
JOIN Projects p ON ep.ProjectId = p.Id;
```

### Query 2: List User Sessions
Join the **users** and **sessions** tables to list the session dates for each user.
```sql
SELECT u.name AS user_name, s.session_date
FROM users u
JOIN sessions s ON u.id = s.user_id;
```

### Query 3: Calculate Order Totals
Join the **products** and **orders** tables to calculate the total price for each order.
```sql
SELECT p.name AS product_name, o.quantity, p.price * o.quantity AS total_price
FROM products p
JOIN orders o ON p.id = o.product_id;
```

---

## File Structure
```
Prosnal_Database/
│── README.md
│── schema.sql        -- Contains all CREATE TABLE and INSERT statements.
│── queries.sql       -- Contains sample SELECT queries.
│── sample_data.csv   -- (Optional) CSV files for sample data.
```

---

## Useful Links
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

---

This `README.md` provides a comprehensive overview of the database creation, data insertion, and query examples. Let me know if you need any modifications or further details!
```

This documentation should help users understand the purpose of each table and query, and it organizes your code in a clear and accessible way.