-- JOIN Queries Task 8 
-----------
--### Company Database – JOIN Queries
use Company_SD;
--1. Display the department ID, department name, manager ID, and the full name of the manager. 
select D.Dnum as 'Department ID', D.Dname as 'Department Name' ,D.MGRSSN as 'Manager ID',E.Fname + ' ' +E.Lname as 'Full Name' from Departments D , Employee E where E.SSN = D.MGRSSN;
 
--2. Display the names of departments and the names of the projects they control. 
select D.Dname as 'Department Name' , P.Pname as ' Project Name' from Departments D inner join Project P on P.Dnum = D.Dnum;

--3. Display full data of all dependents, along with the full name of the employee they depend on. 
select Dept.* ,E.Fname + ' ' +E.Lname as FullName from Dependent Dept inner join Employee E on  E.SSN = Dept.ESSN;

--4. Display the project ID, name, and location of all projects located in Cairo or Alex. 

select Pnumber as 'Project ID' ,Pname as'Project name' , Plocation as 'Location' from Project where City ='Cairo' or City = 'Alex';
--5. Display all project data where the project name starts with the letter 'A'. 
 select * from Project where Pname like 'A%';

--6. Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE. 

select SSN as 'Employee ID', Fname +' '+ Lname as 'Full Name' from Employee where Dno=30 and Salary Between 1000 and 2000;

--7. Retrieve the names of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project. 


SELECT E.Fname +' '+ E.Lname as 'Full Name' FROM Employee E
inner join Works_for W ON E.SSN = W.ESSN
inner join Project P ON W.Pno = P.Pnumber
WHERE E.DNO = 10 and P.Pname = 'AL Rabwah' and W.Hours >= 10;

--8. Find the names of employees who are directly supervised by "Kamel Mohamed". 


SELECT E.Fname +' '+ E.Lname as 'Employee Name' FROM Employee E , Employee S 
WHERE S.SSN = E.Superssn and S.Fname +' '+ S.Lname   = 'Kamel Mohamed';

--9. Retrieve the names of employees and the names of the projects they work on, sorted by project name. 
select * from Employee;
select * from Project;
select * from Works_for;
SELECT E.Fname +' '+ E.Lname as 'Employee Name' , P.Pname as ' Project Name ' FROM Employee E 
inner join Works_for W ON E.SSN = W.ESSN
inner join Project P ON W.Pno = P.Pnumber
order by P.Pname;



--10.  For each project located in Cairo, display the project number, controlling department name, manager's last name, address, and birthdate. 
select * from Departments;
select * from Project;
select * from Employee;

select P.Pnumber as 'Project Number',D.Dname as 'Department Name',E.Lname as 'Manager Last Name', E.Address as 'Manager Address',E.Bdate as 'Manager Birthdate'
FROM Project P
JOIN Departments D ON D.Dnum = P.Dnum
JOIN Employee E ON D.MGRSSN = E.SSN
WHERE P.City = 'Cairo';


--11.  Display all data of managers in the company. 


SELECT M.* FROM Employee E , Employee M WHERE M.SSN = E.Superssn ;


--12.  Display all employees and their dependents, even if some employees have no dependents.

select * from Employee;
select * from Dependent;
SELECT E.* , D.* FROM Employee E LEFT OUTER JOIN Dependent D ON D.ESSN = E.SSN;


-------------------------
-- University Database – JOIN Queries 
use university;
-- 1. Display the department ID, name, and the full name of the faculty managing it. 
select * from Department;
select * from Faculty;

Select D.Department_ID , D.D_Name , F.F_Name from Department D , Faculty F where F.Department_ID = D.Department_ID;

-- 2. Display each program's name and the name of the department offering it. 

select * from Department;
select * from Course;

Select  D.D_Name as 'Department Name' , C.Course_Name as 'Course Name' from Department D , Course C where C.Department_ID = D.Department_ID;


-- 3. Display the full student data and the full name of their faculty advisor. 


select * from Student;
select * from Faculty;
SELECT S.* , F.F_Name as 'faculty advisor'from Student S , Faculty F where S.FID =F.FID;



-- 4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'. 
select * from Course;

-- select Course_ID , Course_Name , Room from Course where Location = 'A' or 'B'



-- 5. Display full data about courses whose titles start with "I" (e.g., "Introduction to..."). 

select Course_Name from Course where Course_Name like 'I%';

-- 6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5. 

-- select S.Fname +' '+ S.Lname as ' Student Name ' from Student S ,Course C where C.Course_ID = 3 and GPA Between 2.5 and 3.5 ;

-- 7. Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course. 

-- select S.Fname +' '+ S.Lname as ' Student Name ' from Student S  , Course C where C.Course_Name='Database' and grade >= 90 

-- 8. Find names of students who are advised by "Dr. Ahmed Hassan". 

--select  S.Fname +' '+ S.Lname as ' Student Name ' from Student S where 
SELECT S.Fname +' '+ S.Lname as ' Student Name ' , F.F_Name as 'faculty advisor'from Student S , Faculty F where F.F_Name= 'Ahmed'
-- 9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title. 


select * from Student;
select * from Course;

select S.Fname +' ' +S.Lname as 'Student Name' , C.Course_Name as 'Course Name ' from Student S ,Course C where C.SID = S.SID order by Course_Name

-- 10.  For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class. 



-- 11.  Display all faculty members who manage any department. 


-- 12.  Display all students and their advisors' names, even if some students don’t have advisors yet.

