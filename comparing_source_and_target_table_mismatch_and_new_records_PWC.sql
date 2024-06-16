use  MediumSQLquestions;

create table source(id int, name varchar(5))

create table target(id int, name varchar(5))

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D')

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');

select * from source;

select * from target;

select s.*, t.*
from source s 
full outer join target t on s.id=t.id;

select s.*, t.*
from source s 
full outer join target t on s.id=t.id
where s.name!=t.name or s.name is NULL or t.name is NULL; 

--using colease function beacuse the id column should be populated always
select coalesce(s.id,t.id) as id, s.name, t.name,
case 
	when (t.name is null ) then 'new in source'
	when s.name is null then 'new in target'
	else 'mismatch'
	end as state_of_data
from source s 
full outer join target t on s.id=t.id
where s.name!=t.name or s.name is NULL or t.name is NULL; 

--Approach 2 :
-- to union all with tag of origin typ and check for mismatch
with cte as (
select *, 'source' as  table_name from source
union all
select *,'target' as table_name from target
)
select id,count (*) as cnt ,
min (name) as name_min, max (name) as name_max,
min(table_name) as table_name_min,max(table_name) as table_max
from cte
group by id having count(*)=1 or (count(*)=2 and min(name)!=max(name))


--
with cte as (
select *, 'source' as  table_name from source
union all
select *,'target' as table_name from target
)
select id,
case when min(name)!=max(name) then 'mismatch'
     when min(table_name)='source' then 'new in source'
	 else 'new in target'
end
from cte
group by id having count(*)=1 or (count(*)=2 and min(name)!=max(name))



