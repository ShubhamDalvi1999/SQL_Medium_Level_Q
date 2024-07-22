use MediumSQLquestions;

create table input (
id int,
formula varchar(10),
value int
)
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);


select * ,left(formula,1) as d1,right(formula,1) as d2,SUBSTRING(formula,2,1) as o
from input;

--Puzzle 
with cte as 
(
select * ,left(formula,1) as d1,right(formula,1) as d2,SUBSTRING(formula,2,1) as o
from input
)
select cte.id, cte.value, cte.formula, cte.o, ipl.value as di_value, ip2. value as d2_value
, case when cte.o='+' then ipl. value +ip2.value else ipl. value-ip2. value end as new_value
from cte
inner join input ipl on cte.d1=ipl.id
inner join input ip2 on cte.d2=ip2.id;