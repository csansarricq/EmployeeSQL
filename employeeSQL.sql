drop table if exists departments, dept_emp, dept_manager, employees, salaries, titles;

CREATE TABLE departments (
  dept_no VARCHAR(30) NOT NULL primary key,
  dept_name VARCHAR (30)
);

drop table dept_emp;
//would this be a composite key
CREATE TABLE dept_emp (
  emp_no text,
  dept_no VARCHAR (30),
  primary key (emp_no, dept_no)
);

drop table dept_manager;
//would this be a composite key
CREATE TABLE dept_manager (
  dept_no VARCHAR(30),
  emp_no text,
  primary key(dept_no, emp_no)
);

drop table employees;
CREATE TABLE employees (
  emp_no text NOT NULL primary key,
  emp_title VARCHAR(30),
  birth_date date,
  first_name VARCHAR (30),
  last_name VARCHAR (30),
  sex VARCHAR(5),
  hire_date date
);

drop table salaries;
CREATE TABLE salaries (
  emp_no Text NOT NULL primary key,
  salary float
);

CREATE TABLE titles (
  title_id VARCHAR(30) NOT NULL primary key,
  title VARCHAR(30)
);


//List the employee number, last name, first name, sex, and salary of each employee (2 points)
select e.emp_no, last_name, first_name, sex, s.salary
from employees as e
left join salaries as s on 
e.emp_no=s.emp_no;

//List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date from employees
where hire_date between '1986-01-01' AND '1987-01-01';


//List the manager of each department along with their department number, department name, employee number, last name, and first name.
select e.emp_no, e.first_name, e.last_name, d.dept_no, dd.dept_name
from employees as e
left join dept_manager as d
on e.emp_no= d.emp_no
left join departments as dd
on d.dept_no =dd.dept_no;


List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select e.emp_no, e.first_name, e.last_name, dd.dept_name, dd.dept_no
from employees as e
left join dept_emp as d
on e.emp_no = d.emp_no
left join departments as dd
on d.dept_no=dd.dept_no;


List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
select first_name, last_name, sex from employees
where first_name = 'Hercules'
and last_name like 'B%';


List each employee in the Sales department, including their employee number, last name, and first name 
select dd.dept_name, d.emp_no, e.last_name, e.first_name
from departments as dd
left join dept_emp as d
on dd.dept_no=d.dept_no
left join employees as e
on d.emp_no=e.emp_no
where dept_name = 'Sales';

List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select dd.dept_name, d.emp_no, e.last_name, e.first_name
from departments as dd
left join dept_emp as d
on dd.dept_no=d.dept_no
left join employees as e
on d.emp_no=e.emp_no
where dept_name = 'Sales' or dept_name = 'Development';

List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
select last_name, count(last_name) as frequency
from employees 
group by last_name 
order by count(last_name) desc;