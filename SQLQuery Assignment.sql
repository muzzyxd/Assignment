CREATE DATABASE assignment;
USE assignment;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate, Salary)
VALUES
    (1, 'Alice', 'Smith', '2022-01-15', 55000.00),
    (2, 'Bob', 'Johnson', '2021-05-10', 62000.00),
    (3, 'Charlie', 'Brown', '2023-03-20', 48000.00);

SELECT * FROM Employees;

UPDATE Employees
SET Salary = 65000.00
WHERE EmployeeID = 2;

DELETE FROM Employees
WHERE EmployeeID = 3;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
	Empid int FOREIGN KEY REFERENCES Employees(EmployeeID)
);
SELECT * FROM Departments;

SELECT * FROM Employees JOIN Departments ON Employees.EmployeeID = Departments.DepartmentID;

SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

GO
CREATE VIEW EmployeeView 
AS
SELECT FirstName,LastName,Salary FROM Employees;

SELECT * FROM EmployeeView;

GO
CREATE PROCEDURE GetEmployeeByID @EmpID INT
AS
BEGIN
    SELECT * FROM Employees WHERE EmployeeID = @EmpID;
END;

EXEC GetEmployeeByID @EmpID = '1';

CREATE TABLE EmployeeLog (
    LogID INT IDENTITY PRIMARY KEY,
    EmployeeID INT NOT NULL,
    LogDate DATETIME DEFAULT GETDATE()
);


GO
CREATE TRIGGER AfterInsert_Employees ON Employees AFTER INSERT
AS
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, LogDate) SELECT EmployeeID, GETDATE() FROM inserted;
END;


INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate, Salary)
VALUES 
    (4, 'Emma', 'Taylor', '2023-06-15', 58000.00),
    (5, 'Liam', 'Miller', '2022-11-20', 64000.00);

SELECT * FROM Employeelog;

