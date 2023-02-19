#find ages to group them
select distinct
	year(e.hire_date) - year(e.birth_date) as Age
from employees e
order by Age desc;
#we can see that hires range from ages 20-47



#return gender as male/female using case statement
#return age group using case statement which categorizes the ages into 4 groups
#return hire date
#return starting salary by joining employee table with salaries table on employee id
#return age by subtracting hire date from birth date
#return department they worked in when they first started by linking tables
#this will return multiple rows as each employee's salary changes over the years so assign row numbers and partition to return only the first result
#create view which will be used in RStudio for analysis, but use query for a live connection in PowerBI without the CREATE VIEW statement

CREATE VIEW hiring_statistics AS

WITH t1 as (
	select
		e.emp_no as EmployeeID,
		year(e.hire_date) - year(e.birth_date) as Age,
        CASE
			WHEN e.gender = 'M'
				THEN 'Male'
				ELSE 'Female'
		END AS Gender,
        e.hire_date as HireDate,
        s.salary as StartingSalary,
        d.dept_name as Department,
        row_number () over (partition by e.emp_no order by salary) as row_num 
	from 
		employees e
        join salaries s on e.emp_no = s.emp_no
        join dept_emp de on s.emp_no = de.emp_no
        join departments d on de.dept_no = d.dept_no
	order by EmployeeID
)

select
	EmployeeID,
    Age,
	CASE
		WHEN Age <=25 THEN "20-25"
        WHEN Age >=26 AND Age <=35 THEN "26-35"
        WHEN Age >=36 AND Age <=40 THEN "36-40"
        WHEN Age >=41 THEN "Over 40"
	END AS AgeGroup,
    Gender,
    HireDate,
    StartingSalary,
    Department
from t1
where row_num = 1
order by EmployeeID;

