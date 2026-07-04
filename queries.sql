--***Your first day as a Data Analyst has started!


--The Marketing Manager asks you for a list of all customers. With first name, last name and the customer's email address.
select first_name, last_name , email from customer;
--A marketing team member asks you about the different prices that have been paid.
select distinct amount from payment order by amount desc ;
--Create a list of all the distinct districts customers are from.
select distinct district from address;
--What is the latest rental date?
select rental_date from rental order by  rental_date desc limit 1;
--How many films does the company have?
select count(*) from film;
--How many distinct last names of the customers are there
select distinct count(*)  last_name from customer;
--The Marketing Manager asks you to order the customer list by the last name.The want to start from "Z" and work towards "A"
select last_name from customer order by last_name desc;
--How many payment were made by the customer with customer_id = 100?
select count(*) from payment where customer_id=100;
--What is the last name of our customer with first name 'ERICA'?
select first_name ,last_name from customer where first_name='ERICA';
--The inventory manager asks you how rentals have not been returned yet (return_date is null).
select count(*) from rental where return_date is  null;
--The sales manager asks you how for a list of all the payment_ids with an amount less than or equal to $2.Include payment_id and the amount.
select payment_id ,amount  from payment where amount <= 2; 

/*The suppcity manager asks you about a list of all the payment of
the customer 322, 346 and 354 where the amount is either less
than $2 or greater than $10.
It should be ordered by the customer first (ascending) and then
as second condition order by amount in a descending order*/


select * from payment where (customer_id=322 or customer_id=346 or customer_id=354) and ( amount < 2 or amount >10) order by customer_id asc , amount desc

/*
There have been 6 complaints of customers about their
payments.
Write a SQL query to get a list of the concerned payments!
Result
It should be 7 payments!
customer_id: 12,25,67,93,124,234
The concerned payments are all the payments of these
customers with amounts 4.99, 7.99 and 9.99 in January 2020*/

SELECT COUNT(*)
FROM payment
WHERE customer_id IN (12,25,67,93,124,234)
AND amount IN (4.99,7.99,9.99)
AND payment_date >= '2020-01-01'
AND payment_date < '2020-02-01';

/*
There have been some faulty payments and you need to help to
found out how many payments have been affected.
How many payments have been made on January 26th and 27th
2020 (including entire 27th) with an amount between 1.99 and 3.99?
*/


select count(*) from payment 
where date(payment_date) in ('2020-01-26' , '2020-01-27') 
and amount between 1.99 and 3.99;

/* 
How many movies are there that contain the "Documentary" in
the description?*/

select count(*) from film where description like '%Documentary%';

/*
How many customers are there with a first name that is
3 letters long and either an 'X' or a 'Y' as the last letter in the last
name?
*/

select count(*) from customer where first_name like '%---%'  AND last_name like '%X' or  last_name like '%Y';

/*How many movies are there that contain 'Saga'
in the description and where the title starts either
with 'A' or ends with 'R'?
Use the alias 'no_of_movies'.*/
SELECT COUNT(*) AS no_of_movies
FROM film
WHERE description LIKE '%Saga%'
AND (title LIKE 'A%' OR title LIKE '%R');

/*Create a list of all customers where the first name contains
'ER' and has an 'A' as the second letter.
Order the results by the last name descendingly.*/
select * from customer 
where first_name like '%ER%'
and
first_name like '_A%'
order by last_name desc;

/*How many payments are there where the amount is either 0
or is between 3.99 and 7.99 and in the same time has
happened on 2020-05-01*/

SELECT COUNT(*)
FROM payment
WHERE (amount = 0 OR amount BETWEEN 3.99 AND 7.99)
AND DATE(payment_date) = '2020-05-01';

/*
There are two competitions between the two employees.
Which employee had the highest sales amount in a single day?
Which employee had the most sales in a single day (not
counting payments with amount = 0?
*/

select staff_id  ,  sum(amount) , count(*)
from payment
group by staff_id
order by count(*) desc

/*
Your manager wants to get a better understanding of the
films.
That's why you are asked to write a query to see the
• Minimum
• Maximum
• Average 
• Sum
of the replacement cost of the films.
*/
select 
max(replacement_cost ), min(replacement_cost ), sum(replacement_cost ) ,  round(avg(replacement_cost ) ,2)
from film;

/*
In 2020, April 28, 29 and 30 were days with very high revenue.
That's why we want to focus in this task only on these days
(filter accordingly).

Find out what is the average payment amount grouped by
customer and day – consider only the days/customers with
more than 1 payment (per customer and day).
Order by the average amount in a descending order.
*/

select 
    customer_id,
    date(payment_date) as payment_day,
    avg(amount) as average_amount,
    count(*) as total_payments
from payment
where date(payment_date) in ('2020-04-28', '2020-04-29', '2020-04-30')
group by customer_id, date(payment_date)
having count(*) > 1
order by average_amount desc;
