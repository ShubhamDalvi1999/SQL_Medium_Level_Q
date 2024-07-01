use MediumSQLquestions;


create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);
delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;


select * from airbnb_searches;


--string_split
select value from string_split('entire home,private room',',')

select * from airbnb_searches
CROSS APPLY string_split(filter_room_types, ',');

select value as room_type,count(1) as no_of_searches from airbnb_searches
CROSS APPLY string_split(filter_room_types, ',')
group by value
order by no_of_searches;