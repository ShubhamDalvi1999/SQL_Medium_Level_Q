use MediumSQLquestions;

CREATE TABLE emp_salary
(
    [emp_id] INTEGER  NOT NULL,
    [name] NVARCHAR(20)  NOT NULL,
    [salary] NVARCHAR(30),
    [dept_id] INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');


--partition by dept,sal to get ranking based on both --to check who are repeating
SELECT emp_id, name, salary,dept_id,RANK() OVER (PARTITION BY dept_id, salary ORDER BY emp_id) AS rank
FROM  emp_salary;

--filtering based on the same salary i.e rank=2 or more
with RankedSalaries as(
SELECT emp_id, name, salary,dept_id,RANK() OVER (PARTITION BY dept_id, salary ORDER BY emp_id) AS rank
FROM  emp_salary)
SELECT salary FROM RankedSalaries  WHERE rank > 1 GROUP BY dept_id, salary;

--combining above
with RankedSalaries as
(
SELECT emp_id, name, salary,dept_id,
RANK() OVER (PARTITION BY dept_id, salary ORDER BY emp_id) AS rank
FROM  emp_salary
)
SELECT emp_id,name,salary,dept_id FROM  RankedSalaries WHERE salary IN 
(  SELECT salary FROM RankedSalaries  WHERE rank > 1 GROUP BY dept_id, salary )
ORDER BY  dept_id, salary, emp_id;
