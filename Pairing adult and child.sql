use MediumSQLquestions;

create table family 
(
person varchar(5),
type varchar(10),
age int
);
delete from family ;
insert into family values ('A1','Adult',54)
,('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);



select * from family;


select *,row_number() over( order by person) as rn from family where type='Adult'

select *,row_number() over( order by person) as rn from family where type='Child'


with a_cte as 
(
select *,row_number() over( order by person) as rn from family where type='Adult'
),c_cte as
(
select *,row_number() over( order by person) as rn from family where type='Child'
)
select a.person as adult, c.person as child from a_cte a left join c_cte c on a.rn=c.rn;


with a_cte as 
(
select *,row_number() over( order by age) as rn from family where type='Adult'
),c_cte as
(
select *,row_number() over( order by age) as rn from family where type='Child'
)
select a.person as adult, c.person as child from a_cte a left join c_cte c on a.rn=c.rn;