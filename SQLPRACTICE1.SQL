--To fetch ALTERNATE records from a table. (EVEN NUMBERED)
SELECT * FROM
(SELECT ROWNUM AS RN,E.* FROM EMPLOYEES E)
WHERE MOD(RN,2)=0;

--To select ALTERNATE records from a table. (ODD NUMBERED)
SELECT * FROM
(SELECT ROWNUM AS RN,E.* FROM EMPLOYEES E)
WHERE MOD(RN,2)=1;

--Find the 3rd MAX salary in the emp table.
SELECT * FROM
(SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DRK,E.* FROM EMPLOYEES E)
WHERE DRK=3;

--Find the 3rd MIN salary in the emp table.
SELECT * FROM
(SELECT DENSE_RANK() OVER(ORDER BY SALARY) AS DRK,E.* FROM EMPLOYEES E)
WHERE DRK=3;

--Select FIRST n records from a table.
SELECT * FROM EMPLOYEES
WHERE ROWNUM=1;

--Select LAST n records from a table
SELECT * FROM 
(SELECT ROWNUM AS RN,E.* FROM EMPLOYEES E ORDER BY EMPLOYEE_ID DESC)
WHERE RN=1;


--List dept no., Dept name for all the departments in which there are no employees in the department.
SELECT * FROM DEPARTMENTS
WHERE EMPLOYEE_ID NOT IN
(SELECT EMPLOYEE_ID FROM DEPARTMENTS);

--How to get 3 Max salaries ?
select distinct salARY from empLOYEES a 
where 3 >= (select count(distinct salARY) 
from empLOYEES b 
where a.salARY <= b.salARY) 
order by a.salARY desc;

--How to get 3 Min salaries ?
select distinct salARY from empLOYEES a 
where 3 >= (select count(distinct salARY) 
from empLOYEES b 
where a.salARY <= b.salARY) 
order by a.salARY;

--Select DISTINCT RECORDS from emp table.
SELECT DISTINCT FIRST_NAME FROM EMPLOYEES;

--How to delete duplicate rows in a table?
DELETE FROM DUPLICATEE
WHERE ROWID NOT IN
(SELECT MAX(ROWID) FROM DUPLICATEE E
GROUP BY EMPLOYEE_ID);

--Count of number of employees in  department  wise.
SELECT DEPARTMENT_ID,COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- Suppose there is annual salary information provided by emp table. 
--How to fetch monthly salary of each and every employee?
SELECT FIRST_NAME,SALARY,SALARY/12 AS MONTHLYSALARY
FROM EMPLOYEES ;

--Select all record from emp table where deptno =10 or 40.
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID=10 OR DEPARTMENT_ID=40; 


--Select all record from emp table where deptno=30 and sal>1500.
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID=30 AND SALARY>1500;

--Select  all record  from emp where job not in SALESMAN  or CLERK.
SELECT * FROM EMPLOYEES 
WHERE JOB_ID='SALESMAN' OR JOB_ID='CLERK';

--Select all record from emp where ename in 'BLAKE','SCOTT','KING'and'FORD'.
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME IN('BLAKE','SCOTT','KING','FORD');

--Select all records where ename starts with ‘S’ and its lenth is 6 char.
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%'
AND LENGTH(FIRST_NAME)=6;

--Select all records where ename may be any no of  character but it should end with ‘R’.
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%R';


--Count  MGR and their salary in emp table.
SELECT MANAGER_ID,SUM(SALARY)
FROM EMPLOYEES
GROUP BY MANAGER_ID;

--In emp table add comm+sal as total sal  .
SELECT COMMISSION_PCT+SALARY AS TOTAL_SAL 
FROM EMPLOYEES;


--Select  any salary <3000 from emp table. 
SELECT * FROM EMPLOYEES
WHERE SALARY > ANY
(SELECT SALARY FROM EMPLOYEES
WHERE SALARY <3000);

--Select  all salary <3000 from emp table. 
SELECT * FROM EMPLOYEES
WHERE SALARY > ALL
(SELECT SALARY FROM EMPLOYEES
WHERE SALARY <3000);


--Select all the employee  group by deptno and sal in descending order.
SELECT DEPARTMENT_ID,SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID,SALARY
ORDER BY SALARY DESC;

--How to retrive record where sal between 1000 to 2000?
SELECT * FROM EMPLOYEES
WHERE SALARY BETWEEN 1000 AND 2000;

--Select all records where dept no of both emp and dept table matches.
SELECT * FROM EMPLOYEES E 
WHERE EXISTS 
(SELECT * FROM DEPARTMENTS D 
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID);

--If there are two tables emp1 and emp2, and both have common record. 
--How can I fetch all the recods but common records only once?

SELECT * FROM EMP1
UNION 
SELECT * FROM EMP2;


--How to fetch only common records from two tables emp and emp1?
SELECT * FROM EMP1 
INTERSECT 
SELECT * FROM EMP2;

-- How can I retrive all records of emp1 those should not present in emp2?
SELECT * FROM EMP1 
MINUS 
SELECT * FROM EMP2;

--Count the total saLARY,  deptno wise where more than 2 employees exist.
SELECT DEPARTMENT_ID,SUM(SALARY) AS TOTSAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>2;
