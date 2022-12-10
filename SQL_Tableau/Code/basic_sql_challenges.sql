/*

INTRODUCTION TO SQL

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
SELECT
**************************/
-- https://www.w3schools.com/sql/sql_SELECT.asp

-- 1. SELECT everything FROM the table authors
SELECT * FROM authors;

-- 2. SELECT the authors first and last name
SELECT au_fname, au_lname FROM authors;

-- 3. SELECT the first name and the last name and merge them in one column by using the CONCAT() function 
-- https://www.w3schools.com/sql/func_mysql_concat.asp
-- remember that you have to separate the two columns by adding space 
SELECT concat(au_fname,' ',au_lname) AS fullname FROM authors;

-- 4. SELECT the distinct first names in authors
-- https://www.w3schools.com/sql/sql_distinct.asp
SELECT DISTINCT au_fname FROM authors;

/**************************
WHERE
**************************/
-- https://www.w3schools.com/sql/sql_WHERE.asp

-- 5. SELECT first and last name FROM authors who have the last name "Ringer"
SELECT au_fname,au_lname FROM authors WHERE au_lname = "Ringer";

-- 6. SELECT first and last name FROM authors whose last name is "Ringer" and fist name is "Anne"
-- https://www.w3schools.com/sql/sql_and_or.asp
SELECT au_fname,au_lname FROM authors WHERE au_lname = "Ringer" AND au_fname = "anne";

-- 7. SELECT first name, last name, and city FROM authors whose city is "Oakland" or "Berkeley", and first name is "Dean"
-- HINT: parenthesis "()" can help
SELECT au_fname,au_lname,city FROM authors WHERE city in ("Oakland","Berkeley") AND au_fname = "Dean";
SELECT au_fname,au_lname,city FROM authors WHERE (city = "Oakland" OR city = "Berkeley") AND au_fname = "Dean";

-- 8. SELECT first, last name, and city FROM authors whose city is "Oakland" or "Berkeley", and last name is NOT "Straight"
SELECT au_fname,au_lname,city FROM authors WHERE city IN ("Oakland","Berkeley") AND au_lname != "Straight";
SELECT au_fname,au_lname,city FROM authors WHERE (city = "Oakland" OR city = "Berkeley") AND au_lname <> "Straight";

/**************************
ORDER BY
**************************/
-- https://www.w3schools.com/sql/sql_orderby.asp

-- 9. SELECT the title and ytd_sales FROM the table titles. Order them by the year to date sales in descending order
SELECT * FROM titles;
SELECT title, ytd_sales FROM titles ORDER BY ytd_sales DESC;

/**************************
LIMIT
**************************/
-- https://www.w3schools.com/mysql/mysql_limit.asp

-- 10. SELECT the top 5 titles with the most ytd_sales FROM the table titles
SELECT title, ytd_sales FROM titles ORDER BY ytd_sales DESC limit 5;

/**************************
MIN and MAX
**************************/
-- https://www.w3schools.com/sql/sql_min_max.asp

-- 11. SELECT the minimum and maximum quantity in table sales. 
SELECT * FROM sales;
SELECT min(qty), max(qty) FROM sales;

/**************************
COUNT, AVG, and SUM
**************************/
-- https://www.w3schools.com/sql/sql_count_avg_sum.asp

-- 12. SELECT the count, average and sum of quantity in the table sales
SELECT count(*), avg(qty), sum(qty) FROM sales;

/**************************
LIKE
**************************/
-- https://www.w3schools.com/sql/sql_like.asp

/*
Here we will also learn to use some wild card characters
https://www.w3schools.com/sql/sql_wildcards.asp
You can ignore 'Wildcard Characters in MS Access'
You need to look at the section 'Wildcard Characters in SQL Server'
*/

-- 13. SELECT all books FROM the table title that contains the word "cooking"
SELECT * FROM publications.titles;
SELECT * FROM titles WHERE title LIKE lower('%Cooking%');

-- 14. SELECT all books that have an "ing" in the title, with at least 4 other characters preceding it
-- for example 'cooking' has 4 characters before the 'ing', so this should be included
-- 'sewing' has only 3 characters before the 'ing', so this shouldn't be included
SELECT * FROM titles WHERE title LIKE '%____ing%';

/**************************
IN
**************************/
-- https://www.w3schools.com/sql/sql_in.asp

-- 15. SELECT all the authors FROM the author table that do not come FROM the cities Salt Lake City, Ann Arbor, and Oakland.
SELECT * FROM publications.authors;
SELECT * FROM authors WHERE NOT city = "Salt Lake City" AND NOT city = "Ann Arbor" AND NOT city = "Oakland"; 
SELECT * FROM authors WHERE city NOT IN("Salt Lake City", "Oakland","Ann Arbor");


/*
The differences between IN, LIKE, and =

IN : takes many values to look for, such as a list of values, and does not work with the wildcards.
= : takes only one value to look for and does not work with wildcards.
LIKE: takes only one value to look for and works with wildcards. It is also case insentsitive
*/

/**************************
BETWEEN
**************************/
-- https://www.w3schools.com/sql/sql_between.asp

-- 16. SELECT all the order numbers with a quantity sold between 25 and 45 FROM the table sales
SELECT * FROM publications.sales;
SELECT * FROM sales WHERE qty BETWEEN 25 and 45; 

-- 17. SELECT all the orders between 1993-03-11 and 1994-09-13
SELECT * FROM sales WHERE ord_date BETWEEN '1993-03-11' AND '1994-09-13';

/**************************
GROUP BY
**************************/
--  https://www.w3schools.com/sql/sql_groupby.asp

-- 18. Find the total amound of authors for each state 
SELECT * FROM publications.authors;
SELECT state, count(*) FROM authors GROUP BY state;

-- 19. Find the total amount of authors by each state and order them in descending order
SELECT state, count(*) FROM authors GROUP BY state ORDER BY count(*) DESC;

-- 20. SELECT the maximum price for each publisher id in the table titles.
SELECT * FROM publications.titles;
SELECT pub_id, max(price) FROM titles GROUP BY pub_id;

-- 21. Find out the top 3 stores with the most sales
SELECT * FROM publications.sales;
SELECT stor_id, sum(qty) FROM sales GROUP BY stor_id ORDER BY sum(qty) DESC limit 3;

/**************************
HAVING
**************************/
-- https://www.w3schools.com/sql/sql_having.asp

-- 22. SELECT, for each publisher, the total number of titles FROM each book type, with an average price higher than 12
SELECT pub_id, type, count(*), AVG(price) FROM titles GROUP BY pub_id, type having avg(price) > 12;

-- 23. SELECT, FROM each publisher, the total number of titles for each book type, with an average price higher than 12 and order them by the average price
SELECT pub_id, type, count(*),avg(price) FROM titles GROUP BY pub_id, type having avg(price) > 12 ORDER BY avg(price);

-- 24. SELECT all the states and cities that have more than 1 contract
SELECT * FROM publications.authors;
SELECT state, city, sum(contract) FROM authors GROUP BY state, city having sum(contract) > 1;
#SELECT state, city, contract FROM authors where contract > 1; GROUP BY state, city;

/* 
The main difference between WHERE and HAVING is that:
the WHERE clause is used to specify a condition for filtering most records,
the HAVING clause is used to specify a condition for filtering values FROM an aggregate (such as MAX(), AVG(), COUNT() etc...)
 */

/**************************
FINAL CHALLENGES
**************************/

-- 25. SELECT the top 5 orders with most quantity sold between 1993-03-11 and 1994-09-13 FROM the table sales
SELECT * FROM publications.sales;
SELECT * FROM sales WHERE ord_date between '1993-03-11' and '1994-09-13' ORDER BY qty DESC limit 5;

-- 26. How many authors have an "i" in their first name, and have the state UT, MD, or KS
SELECT * FROM publications.authors;
#SELECT * FROM publications.authors WHERE au_fname like '%i%' and state ='UT' and state = 'MD' and state = 'KS';
SELECT * FROM authors WHERE au_fname like '%i%' and state in ('UT','MD','KS');

-- 27. In California, how many authors are there in cities that contain an "o" in the name?
-- Show only results for cities with more than 1 author.
-- Sort the cities ascendingly by author count.
SELECT * FROM authors;
/*SELECT city, concat(au_fname,' ',au_lname) as full_name, count(full_name) FROM publications.authors  WHERE state = 'CA' and city like '%o%'
GROUP BY city having count(full_name) > 1 ORDER BY city;*/

SELECT city, count(au_fname) FROM authors  WHERE state = 'CA' and city like '%o%'
GROUP BY city having count(au_fname) > 1 ORDER BY count(au_fname);


