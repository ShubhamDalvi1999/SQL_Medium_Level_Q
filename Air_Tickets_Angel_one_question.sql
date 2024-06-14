use MediumSQLquestions;
CREATE TABLE air_tickets (
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);


INSERT INTO air_tickets (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);

/*write a query to find "busiest route" along with total ticket count
oneway_round ='0' -> One Way Trip
oneway_round ='R' -> Round Trip
Note: DEL -> BOM is different route from BOM -> DEL*/

--initially we see that the to calculate the busiest 
-- we need to count the rows per airline_number, but it will exclude the round trip count
-- so we union the round trips to include all the rows

with cte_temp as
(
select origin, destination, oneway_round, ticket_count from air_tickets
union all
select destination, origin, oneway_round, ticket_count from air_tickets where oneway_round='R'
)
select origin, destination, sum(ticket_count) as tc from cte_temp group by origin,destination
order by tc desc;