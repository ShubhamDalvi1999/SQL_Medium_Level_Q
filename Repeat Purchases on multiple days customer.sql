use MediumSQLquestions;

CREATE TABLE purchases (
    user_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    purchase_date DATETIME
);

delete  from purchases;

-- Insert data into purchases table
INSERT INTO purchases (user_id, product_id, quantity, purchase_date) VALUES
(536, 3223, 6, '2022-01-11 12:33:44'), -- Repeat customer
(536, 3223, 5, '2022-03-02 09:33:28'), -- Repeat customer
(536, 1435, 45, '2022-03-02 08:40:00'), -- Repeat customer, different product
(827, 3585, 35, '2022-02-20 14:05:26'), -- Repeat customer
(827, 3585, 20, '2022-04-09 00:00:00'), -- Repeat customer
(123, 1111, 12, '2022-05-15 10:15:00'), -- Non-repeat customer
(456, 2222, 8, '2022-05-16 11:20:30'), -- Non-repeat customer
(789, 3333, 20, '2022-05-17 12:25:45'), -- Non-repeat customer
(101, 7777, 25, '2022-05-21 16:45:45'), -- Repeat customer
(101, 7777, 30, '2022-05-25 20:05:45'), -- Repeat customer
(202, 8888, 30, '2022-05-22 17:50:00'), -- Non-repeat customer
(303, 9999, 18, '2022-05-23 18:55:15'), -- Non-repeat customer
(404, 1010, 22, '2022-05-24 19:00:30'), -- Non-repeat customer
(505, 2020, 15, '2022-05-25 20:05:45'), -- Non-repeat customer
(606, 3030, 9, '2022-05-26 21:10:00'), -- Non-repeat customer
(707, 4040, 13, '2022-05-27 22:15:15'), -- Non-repeat customer
(808, 5050, 17, '2022-05-28 23:20:30'), -- Repeat customer
(808, 5050, 19, '2022-05-30 01:30:00'), -- Repeat customer
(909, 6060, 21, '2022-05-29 00:25:45'), -- Non-repeat customer
(1010, 7070, 19, '2022-05-30 01:30:00'); -- Non-repeat customer

select user_id,product_id, count(distinct purchase_date) as p_date
from purchases group by user_id,product_id
having count(distinct purchase_date)>1 