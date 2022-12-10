/*

More advanced SQL

------------------------------------------------------------------------------------------------

HOW TO GET THE SCHEMA OF A DATABASE: 
* Windows/Linux: Ctrl + r
* MacOS: Cmd + r

*/

/**************************
***************************
CHALLENGES
***************************
**************************/

-- In SQL we can have many databases, they will show up in the schemas list
-- We must first define which database we will be working with
USE publications; 
 
/**************************
ALIAS
**************************/
-- https://www.w3schools.com/sql/sql_alias.asp

-- 1. From the sales table, change the column name qty to Quantity
select qty as Quantity from sales;

-- 2. Assign a new name into the table sales. Select the column order number using the table alias

#select ord_num as Order_number from sales as new_sales;
select s.ord_num from sales s;

/**************************
JOINS
**************************/
-- https://www.w3schools.com/sql/sql_join.asp

/* We will only use LEFT, RIGHT, and INNER joins this week
You do not need to worry about the other types for now */

-- LEFT JOIN example
-- https://www.w3schools.com/sql/sql_join_left.asp
SELECT *
FROM stores s
LEFT JOIN discounts d 
#ON d.stor_id = s.stor_id;
ON s.stor_id = d.stor_id;

-- RIGHT JOIN example
-- https://www.w3schools.com/sql/sql_join_right.asp
SELECT *
FROM stores s
RIGHT JOIN discounts d
ON d.stor_id = s.stor_id;

-- INNER JOIN example
-- https://www.w3schools.com/sql/sql_join_inner.asp
SELECT *
FROM stores s
INNER JOIN discounts d 
ON d.stor_id = s.stor_id;

-- 2nd option
select * from stores s, discounts d where d.stor_id = s.stor_id;


-- 3. Using LEFT JOIN: in which cities has "Is Anger the Enemy?" been sold?
-- HINT: you can add WHERE function after the joins
select * from titles;
select * from sales;
select * from stores;
#select city, title from sales s left join titles t on p.pub_id = t.pub_id where t.title = 'Is Anger the Enemy?';

select * from titles 
inner join sales using(title_id)
inner join stores using(stor_id)
where title="Is Anger the Enemy?";

SELECT * FROM titles t LEFT JOIN sales s ON t.title_id = s.title_id LEFT JOIN stores st ON s.stor_id = st.stor_id
WHERE t.title = 'Is Anger the Enemy?';



-- 4. Using RIGHT JOIN: select all the books (and show their titles) that have a link to the employee Howard Snyder.
select * from employee;
select * from titles;
select t.title, e.fname, e.lname from employee e RIGHT JOIN titles t on e.pub_id = t.pub_id where e.fname = 'Howard' and e.lname = 'Snyder';
select t.title, e.fname, e.lname from titles t LEFT JOIN employee e on e.pub_id = t.pub_id where e.fname = 'Howard' and e.lname = 'Snyder';

-- 5. Using INNER JOIN: select all the authors that have a link (directly or indirectly) with the employee Howard Snyder
select a.au_fname, a.au_lname, e.fname, e.lname from authors a 
inner join titleauthor ta on a.au_id = ta.au_id
inner join titles t on ta.title_id = t.title_id
inner join publishers p on t.pub_id = p.pub_id
inner join employee e on p.pub_id = e.pub_id
where e.fname = 'Howard' and e.lname = 'Snyder';

-- 6. Using the JOIN of your choice: Select the book title with higher number of sales (qty)
select t.title as Book_title, sum(s.qty) as Quantity from titles t left join sales s on t.title_id = s.title_id
group by t.title order by sum(s.qty) DESC limit 1;

/**************************
CASE
**************************/
-- https://www.w3schools.com/sql/sql_case.asp

-- 7. Select everything from the sales table and create a new column called "sales_category" with case conditions to categorise qty
--  * qty >= 50 high sales
--  * 20 <= qty < 50 medium sales
--  * qty < 20 low sales
select * , 
case 
when qty >= 50 then 'high sales'
when qty < 50 and qty >= 20 then 'medium sales'
else 'low sales'
end as sales_category
from sales;

-- 8. Adding to your answer from question 7. Find out the total amount of books sold (qty) in each sales category
-- i.e. How many books had high sales, how many had medium sales, and how many had low sales
select qty as Quantity,
case 
when qty >= 50 then 'high sales'
when qty < 50 and qty >= 20 then 'medium sales'
else 'low sales'
end as sales_category,
sum(qty) as Total_Amount
from sales
group by sales_category;

-- 9. Adding to your answer from question 8. Output only those sales categories that have a SUM(qty) greater than 100, and order them in descending order
select qty as Quantity,
case 
when qty >= 50 then 'high sales'
when qty < 50 and qty >= 20 then 'medium sales'
else 'low sales'
end as sales_category,
sum(qty) as Total_Amount
from sales
group by sales_category
having sum(qty) > 100
order by sum(qty) DESC;

-- 10. Find out the average book price, per publisher, for the following book types and price categories:
-- book types: business, traditional cook and psychology
-- price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
select * from titles;
#select * from publishers;
select pub_id, avg(price),
case
when price <= 5 then 'super low'
when price <= 10 then 'low'
when price <= 15 then 'medium'
else 'high'
end as price_category
from titles 
where type in ('business', 'traditional','cook','psychology')
group by pub_id, price_category;

