#find current managers of each department
#give them outlook accounts for user permission table
select
    concat(e.first_name, " ",e.last_name) as "Manager/User",
    dm.from_date as "Manager Since",
    d.dept_no as DepartmentID,
    concat(
		lower(substring(e.first_name, 1, 1)), 
		lower(e.last_name),
        "@outlook.com") as Email
from employees e
	join dept_manager dm on e.emp_no = dm.emp_no
    join departments d on dm.dept_no = d.dept_no
where to_date = '9999-01-01';

#import department table for RLS filtering
select 
	dept_no as DepartmentID,
    dept_name as Department
from departments order by dept_no;