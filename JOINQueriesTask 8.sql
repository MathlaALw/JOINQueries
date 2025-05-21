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


select * from Student;
select * from Course;
select * from Faculty;
select S.Fname +' ' +S.Lname as 'Student Name' , C.Course_Name as 'Course Name ', D.D_Name as 'Department Name ' from Student S 
inner join Course C  ON C.SID = S.SID
inner join Faculty F  ON F.FID = S.FID
inner join Department D on D.Department_ID =F.Department_ID



-- 11.  Display all faculty members who manage any department. 

select * from Faculty;
select * from Department;

SELECT F.* FROM Faculty F , Department D WHERE D.Department_ID = F.Department_ID ;

-- 12.  Display all students and their advisors' names, even if some students don’t have advisors yet.

select * from Student;
select * from Faculty;

SELECT S.* , F.F_Name as 'advisors name' FROM Student S LEFT OUTER JOIN Faculty F ON F.FID = S.FID;

-------------------------------------------

-- Airline Database – JOIN Queries
use airline;

-- 1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it. 

select * from FlightLeg;
select * from Airport;

select F.Leg_No ,  F.Sechuled_Dep_Time ,  F.Sechuled_Arr_Time, A.A_Name from FlightLeg F inner join Airport A on A.Airport_Code=F.Airport_Code
-- 2. Display all flight numbers and the names of the departure and arrival airports. 
select * from FlightLeg;
select * from Airport;
select * from Flight
select * from LegInstance;

select F.Number as 'flight numbers' , A.A_Name as  'departure_airport' , A.A_Name as 'arrival_airport' from Flight F 
inner join  FlightLeg FL on F.Number = FL.Number
inner join Airport A on A.Airport_Code = F.Number



-- 3. Display all reservation data with the name and phone of the customer who made each booking. 
select * from Reservation;

select R_Date as 'Reservation Data', Customer_Name as 'Customer Name' , CPhone as 'Customer Phone' from Reservation;

-- 4. Display IDs and locations of flights departing from 'CAI' or 'DXB'. 
select * from Flight
-- select Number as ' Flight ID ', Location  from Flight where Departing from 'CAI' or 'DXB'

-- 5. Display full data of flights whose names start with 'A'. 

select * from Flight where Airline like 'A%'

-- 6. List customers who have bookings with total payment between 3000 and 5000. 

-- select Customer_Name as 'Customer Name'  from Reservation where Total between 3000 and 5000;

-- 7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats. 

select * from Flight
select * from Reservation
select * from LegInstance
select * from Seats


select R.Customer_Name as 'Customer Name'  from Reservation R inner join Seats S on S.Seat_No = R.Seat_No
inner join LegInstance L on L.Leg_Date = R.Leg_Date
inner join FlightLeg FL on FL.Leg_No = L.Leg_No
inner join Flight F on F.Number = FL.Number 
where S.Seat_No > 2 ;

-- 8. Find names of passengers whose booking was handled by agent "Youssef Hamed". 

--  select Customer_Name as 'Customer Name'  from Reservation 

-- 9. Display each passenger’s name and the flights they booked, ordered by flight date. 

select R.Customer_Name as 'Customer Name' , F.Airline from Reservation R inner join LegInstance L on L.Leg_Date = R.Leg_Date
inner join FlightLeg FL on Fl.Leg_No =L.Leg_No
inner join Flight F on F.Number=Fl.Number
order by L.Leg_Date

-- 10.  For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 

SELECT F.Number,FL.Sechuled_Dep_Time,A.A_Name FROM Flight F
inner join FlightLeg FL ON F.Number = F.Number
inner join Airport A ON FL.Airport_Code = A.Airport_Code
WHERE A.A_Name = 'Cairo';

-- 11.  Display all staff members who are assigned as supervisors for flights. 

--SELECT s.staff_id,s.staff_name,s.role FROM Staff s inner join Flights f ON s.staff_id = f.supervisor_id;

-- 12.  Display all bookings and their related passengers, even if some bookings are unpaid.

-- SELECT b.booking_id,b.paid,p.passenger_id,p.passenger_name FROM Bookings b LEFT JOIN Passengers p ON b.passenger_id = p.passenger_id;


------------------------------------------

-- Hotel Database – JOIN Queries 
use hotel
-- 1. Display hotel ID, name, and the name of its manager. 
 
 select B.Branch_ID as ' Hotel ID ' , B.B_Name as ' Hotel Name ' from Branch B inner join Staff S on S.S_ID = B.S_ID

-- 2. Display hotel names and the rooms available under them. 

select B.B_Name as ' Hotel Name ', R.Room_Number  from Branch B Left outer join Room R on R.Branch_ID = B.Branch_ID 

-- 3. Display guest data along with the bookings they made. 
select * from booking
select C.* from Customer C Right outer join Booking B on B.C_ID =C.C_ID

-- 4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'. 

SELECT B.*,Br.B_Name,Br.Location FROM Booking B
inner join Branch Br ON Br.S_ID = B.S_ID
WHERE Br.Location IN ('Hurghada', 'Sharm El Sheikh');

-- 5. Display all room records where room type starts with "S" (e.g., "Suite", "Single"). 

select * from Room where R_Type like 'S%'

-- 6. List guests who booked rooms priced between 1500 and 2500 LE. 

--select C.C_Name from Customer C inner join Room R on R.C_ID = C.C_ID where R.Price between 1500 and 2500; 

-- 7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown". 

 select C.C_Name from Customer C inner join Booking B on B.C_ID = C.C_ID 
 inner join Room R on R.C_ID = C.C_ID
 inner join Branch Br on Br.Branch_ID = R.Branch_ID
 where B.Booking_State = 'Confirmed' and Br.B_Name = 'Hilton Downtown'

-- 8. Find guests whose bookings were handled by staff member "Mona Ali". 
select * from Staff
select * from Booking
select * from Customer
select C.C_Name from Customer C 
inner join Booking B on B.C_ID = C.C_ID 
inner join Staff S on S.S_ID = B.S_ID
where S_Name = 'Hassan Al-Habsi'



-- 9. Display each guest’s name and the rooms they booked, ordered by room type. 

select C.C_Name  from Customer C inner join Room R on R.C_ID= C.C_ID order by R.R_Type

-- 10.  For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info. 

SELECT B.Branch_ID,B.B_Name,S.S_Name AS 'Manager Name ',S.Job_Title
FROM Branch B inner join Staff S ON B.S_ID = S.S_ID
WHERE B.Location = 'Cairo';

-- 11.  Display all staff members who hold 'Manager' positions. 

select * from Staff where Job_Title = 'Branch Manager'

-- 12.  Display all guests and their reviews, even if some guests haven't submitted any reviews.

-- SELECT C.C_ID,C.C_Name,C.Email,R.rating FROM Customer C LEFT JOIN Reviews R ON C.C_ID = R.C_ID;


-------------------------

-- Bank Database – JOIN Queries 
use bank;
-- 1. Display branch ID, name, and the name of the employee who manages it. 

select * from Employee
Select * from Branch

select B.Branch_ID , B.Branch_Address , E.E_Name from  Branch B inner join Employee E on B.Branch_ID = E.Branch_ID

-- 2. Display branch names and the accounts opened under each. 

select * from Employee
Select * from Branch

-- select B.Branch_ID , B.Branch_Address  from  Branch B inner join Customer C on B.Branch_ID = C.Branch_ID inner join 
-- 3. Display full customer details along with their loans. 
select * from Loans
select * from Customer
select C.* from Customer C inner join Loans L on L.Customer_ID = C.Customer_ID

-- 4. Display loan records where the loan office is in 'Alexandria' or 'Giza'. 

Select L.* from Loans L where L.L_Type in ('Personal' ,'Education');

-- 5. Display account data where the type starts with "S" (e.g., "Savings"). 

select * from Accounts where A_Type like 'S%'

-- 6. List customers with accounts having balances between 20,000 and 50,000. 

select C.* from Customer C inner join Accounts A on A.Customer_ID = C.Customer_ID where A.Balance between 200 and 500;

-- 7. Retrieve customer names who borrowed more than 100,000 LE from 'Cairo Main Branch'. 

-- select C.CName from Customer C inner join Accounts A on A.Customer_ID = C.Customer_ID where A.Balance > 100 and B.Branch_Address= 'Cairo Main Branch'

-- 8. Find all customers assisted by employee "Amira Khaled". 

select C.* from Customer C inner join Employee E on E.Employee_ID = C.Employee_ID  where E_Name = 'Amira Khaled'

-- 9. Display each customer’s name and the accounts they hold, sorted by account type. 

select C.CName as 'Customer Name' ,A.Account_Number as 'Account Number' from Customer C inner join Accounts A on A.Customer_ID = C.Customer_ID order by A.A_Type

-- 10.  For each loan issued in Cairo, show loan ID, customer name, employee handling it, and branch name. 

SELECT L.Loans_ID,C.CName, E.E_Name AS handled_by,b.Branch_Address
FROM Loans L inner join Customer C ON L.customer_id = C.customer_id
inner join Employee E ON L.employee_id = E.employee_id
inner join Branch B ON L.Loans_ID = B.branch_id
WHERE B.Branch_Address = 'Cairo';

-- 11.  Display all employees who manage any branch. 

--SELECT E.Employee_ID,E.E_Name FROM Employee E inner join Branch B ON E.Employee_ID = B.Manager_id;

-- 12.  Display all customers and their transactions, even if some customers have no transactions yet.

-- SELECT C.Customer_ID,C.CName,T.Transactions_ID,T.amount,T.T_Date FROM Customer C LEFT JOIN Transactions T ON C.Customer_ID = T.Customer_ID;
