CREATE DATABASE IF NOT EXISTS prosnal_database;
USE prosnal_database;

CREATE TABLE IF NOT EXISTS Employees (
    Id INT,
    Name VARCHAR(255),
    Salary INT,
    Department VARCHAR(255)
);

INSERT INTO Employees (Id, Name, Salary, Department)
VALUES (1, 'John Doe', 50000, 'HR'),
       (2, 'Jane Smith', 60000, 'Finance'),
       (3, 'Mike Johnson', 70000, 'IT'),
           (4, 'Sarah Black', 60000, 'Finance'),
           (5, 'David White', 70000, 'IT');
           
CREATE TABLE IF NOT EXISTS Projects (
     Id INT,
     Name VARCHAR(255),
     Department VARCHAR(255)
     );
     
 INSERT INTO Projects (Id, Name, Department)
     VALUES (1, 'Project A', 'IT'),
          (2, 'Project B', 'Finance'),
          (3, 'Project C', 'IT');
          
CREATE TABLE IF NOT EXISTS EmployeeProjects (
     EmployeeId INT,
     ProjectId INT
     );
     
 INSERT INTO EmployeeProjects (EmployeeId, ProjectId)
     VALUES (1, 1),
          (1, 2),
          (2, 1),
          (3, 1),
          (3, 3),
          (4, 2),
          (5, 1);
          
SELECT e.Name AS EmployeeName, e.Department, p.Name AS ProjectName, p.Department
FROM Employees e
JOIN EmployeeProjects ep
ON e.Id = ep.EmployeeId
JOIN Projects p
ON ep.ProjectId = p.Id;

CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO users (id, name, email)
VALUES (1, 'John Doe', 'john.doe@example.com'),
       (2, 'Jane Smith', 'antima@example.com');

CREATE TABLE sessions (
    id INT PRIMARY KEY,
    user_id INT,
    session_date DATE
);

INSERT INTO sessions (id, user_id, session_date)
VALUES (1, 1, '2022-01-01'),
       (2, 1, '2022-01-02'),
       (3, 2, '2022-01-03');

SELECT u.name AS user_name, s.session_date
FROM users u
JOIN sessions s
ON u.id = s.user_id;

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, name, price)
VALUES (1, 'Product A', 10.99),
           (2, 'Product B', 20.99),
           (3, 'Product C', 30.99);
           
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

INSERT INTO orders (id, product_id, quantity)
VALUES (1, 1, 5),
       (2, 2, 3),
       (3, 3, 1),
       (4, 1, 2),
       (5, 2, 4);
       
SELECT p.name AS product_name, o.quantity, p.price * o.quantity AS total_price
FROM products p
JOIN orders o
ON p.id = o.product_id;
```
