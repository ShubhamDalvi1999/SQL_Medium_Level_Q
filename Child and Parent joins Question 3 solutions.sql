use MediumSQLquestions;

create table people
(id int primary key not null,
 name varchar(20),
 gender char(2));

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people (id, name, gender)
values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');

insert into relations(c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);

select * from people;
select * from relations;

select r.c_id,p.name as mothers_name
from relations r inner join people p on r.p_id=p.id and gender='F' 

select r.c_id,p.name as mothers_name
from relations r inner join people p on r.p_id=p.id and gender='M' 


--APPROACH 1:

-- joining two cte to get two different coulmns from each 
with m as 
(
	select r.c_id,p.name as mothers_name
	from relations r inner join people p on r.p_id=p.id and gender='F' 
), 
f as 
(
	select r.c_id,p.name as fathers_name
	from relations r inner join people p on r.p_id=p.id and gender='M' 
)
select f.c_id as child_id, m.mothers_name, f.fathers_name
from f inner join m on f.c_id=m.c_id

--joining one more time to get child name
with m as 
(
	select r.c_id,p.name as mothers_name
	from relations r inner join people p on r.p_id=p.id and gender='F' 
), 
f as 
(
	select r.c_id,p.name as fathers_name
	from relations r inner join people p on r.p_id=p.id and gender='M' 
)
select f.c_id as child_id,p.name as child_name, m.mothers_name, f.fathers_name
from f inner join m on f.c_id=m.c_id
inner join people p on p.id=f.c_id


--APPROACH 2
select r.*,p.name as mother_name,f.name as father_name from relations r 
left join people p on r.p_id=p.id and p.gender='F' -- to get the mothers of all c_id's by matching p_id with id
left join people f on r.p_id=f.id and f.gender='M';-- to get the fathers of all c_id's by matching p_id with id

select r.c_id,c.name, max(p.name) as mother_name,max(f.name) as father_name from relations r 
left join people p on r.p_id=p.id and p.gender='F' 
left join people f on r.p_id=f.id and f.gender='M'
inner join people c on r.c_id=c.id 
group by r.c_id, c.name;


--MENTONS PRO approach
select r.*,p.* 
from relations r 
inner  join people p on r.p_id=p.id;

select r.*,p.* , 
case when p.gender='F' then name end as mother_name,
case when p.gender='M' then name end as father_name
from relations r 
inner  join people p on r.p_id=p.id;

select r.c_id , 
max(case when p.gender='F' then name end) as mother_name,
max(case when p.gender='M' then name end) as father_name
from relations r 
inner  join people p on r.p_id=p.id
group by r.c_id;
