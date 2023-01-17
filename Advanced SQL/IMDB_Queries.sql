USE imdb_ijs;

-- The big picture
-- 1. How many actors are there in the actors table?
SELECT DISTINCT count(id) from actors; #Answer - 817718

-- 2. How many directors are there in the directors table?
SELECT DISTINCT COUNT(id) from directors; #Answer - 86880

-- 3. How many movies are there in the movies table?
SELECT  DISTINCT COUNT(id) from movies; #Answer - 388269

-- Exploring the movies
-- 1. From what year are the oldest and the newest movies? What are the names of those movies?
SELECT year,name 
FROM movies 
WHERE year=(select min(year) from movies) 
OR year=(select max(year) from movies);

-- 2. What movies have the highest and the lowest ranks? HIGHEST - 9.9 AND LOWEST - 1
SELECT name, `rank` 
FROM movies
WHERE `rank` = (SELECT MAX(`rank`) FROM movies)
OR `rank` = (SELECT MIN(`rank`) FROM movies);

-- 3. What is the most common movie title? Answer - MOVIE - Eurovision Song Contest, The HAS MOST TITLE = 49
SELECT name, COUNT(name)
FROM movies
GROUP BY name
ORDER BY 2 DESC;

-- Understanding the database
-- 1. Are there movies with multiple directors? Answer - MOVIE_ID = 382052 WITH COUNT = 87
SELECT movie_id, COUNT(director_id)
FROM movies_directors
GROUP BY movie_id
HAVING COUNT(director_id) > 1
ORDER BY 2 DESC;

-- 2. What is the movie with the most directors? Why do you think it has so many? Answer - MOVIE = "Bill, The" WITH COUNT = 87
SELECT m.name, m.year, COUNT(md.director_id) as no_of_dir
FROM movies_directors md
JOIN movies m
	ON md.movie_id = m.id
GROUP BY movie_id
HAVING COUNT(director_id) > 1
ORDER BY 3 DESC;

-- 3.On average, how many actors are listed by movie? Answer - 11.4303
WITH actors_per_movie AS (
	SELECT movie_id, COUNT(actor_id) AS no_actors
	FROM roles
	GROUP BY movie_id)
SELECT AVG(no_actors)
FROM actors_per_movie;

-- 4.Are there movies with more than one “genre”?
SELECT movie_id, COUNT(genre)
FROM movies_genres
GROUP BY movie_id
HAVING COUNT(genre) > 1
ORDER BY COUNT(genre) DESC;

-- Looking for specific movies
-- 1.Can you find the movie called “Pulp Fiction”? Which actors where casted on it?
select a.first_name as actor_first_name, a.last_name as actor_last_name,m.name,m.year from movies as m 
inner join roles as r
on m.id=r.movie_id inner join actors as a
on r.actor_id=a.id
WHERE m.name LIKE "pulp fiction";

-- Who directed it? 
SELECT d.first_name, d.last_name
FROM directors d
JOIN movies_directors md
	ON d.id = md.director_id
JOIN movies m
	ON md.movie_id = m.id
WHERE m.name LIKE "pulp fiction";

-- 2. Can you find the movie called “La Dolce Vita”? Who directed it?
SELECT d.first_name, d.last_name
FROM directors d
JOIN movies_directors md
	ON d.id = md.director_id
JOIN movies m
	ON md.movie_id = m.id
WHERE m.name LIKE "Dolce Vita, la";

-- Which actors where casted on it?
select a.first_name as actor_first_name, a.last_name as actor_last_name,m.name,m.year from movies as m 
inner join roles as r
on m.id=r.movie_id inner join actors as a
on r.actor_id=a.id
WHERE m.name LIKE "Dolce Vita, la";

-- 3. When was the movie “Titanic” by James Cameron released? Answer - 1997
-- Hint 1: there are many movies named “Titanic”. We want the one directed by James Cameron.
-- Hint 2: the name “James Cameron” is stored with a weird character on it.
select m.name, m.year,d.first_name as dir_fname,d.last_name as dir_lname
from movies as m 
inner join movies_directors as md 
on m.id=md.movie_id 
inner join directors as d
on md.director_id=d.id 
where m.name= 'Titanic' And (d.first_name like '%James%' AND d.last_name like '%Cameron%');

-- Actors and directors
-- 1. Who is the actor that acted more times as “Himself”?
SELECT a.first_name, a.last_name, COUNT(a.id)
FROM actors a
JOIN roles r
	ON a.id = r.actor_id
WHERE role LIKE "himself"
GROUP BY a.id, a.first_name, a.last_name
ORDER BY COUNT(a.id) DESC;

-- 2. What is the most common name for actors? 
SELECT first_name, COUNT(first_name)
FROM actors
GROUP BY 1
ORDER BY 2 DESC;
/* # first_name, COUNT(first_name)
John, 4371 */

SELECT last_name, COUNT(last_name)
FROM actors
GROUP BY 1
ORDER BY 2 DESC;
/* # last_name, COUNT(last_name)
Smith, 2425 */

WITH concat_names as (SELECT 
    concat(first_name,' ',last_name) fullname
FROM
	actors)
SELECT fullname, COUNT(fullname)
FROM concat_names
GROUP BY 1
ORDER BY 2 DESC;

-- 3. And for directors?
WITH concat_names as (SELECT 
    concat(first_name,' ',last_name) fullname
FROM
	directors)
SELECT fullname, COUNT(fullname)
FROM concat_names
GROUP BY 1
ORDER BY 2 DESC;

-- Analysing genders
-- 1. How many actors are male and how many are female?
SELECT gender, COUNT(gender)
FROM actors
GROUP BY gender;
/* # gender, COUNT(gender)
F, 304412
M, 513306 */

WITH concat_names as (SELECT 
    concat(first_name,' ',last_name) fullname,gender
FROM
	actors)
SELECT gender, COUNT(fullname)
FROM concat_names
GROUP BY gender;

-- 2. What percentage of actors are female, and what percentage are male?
select (select Count(gender) as Male from actors where gender='M')/(select Count(gender) as Total from actors) as Male_percentage;
select (select Count(gender) as Female from actors where gender='F')/(select Count(gender) as Total from actors) as Female_percentage;

-- Movies across time
-- 1. How many of the movies were released after the year 2000? Answer - 46006
select count(name) Total from movies where year>2000;

-- 2. How many of the movies where released between the years 1990 and 2000? Answer - 91138
 select count(name) Total from movies where year between 1990 and 2000;
 
 -- 3. Which are the 3 years with the most movies? How many movies were produced on those years?
select year, count(name) as count from movies  group by year order by count desc limit 3;

-- 4. What are the top 5 movie genres?
WITH top AS (SELECT
	RANK() OVER (ORDER BY COUNT(movie_id) DESC) ranking,
    genre,
    COUNT(movie_id) total
FROM movies_genres
GROUP BY genre
ORDER BY 1)
SELECT ranking, genre, total
FROM top
WHERE ranking <= 5;

-- 4.1 What are the top 5 movie genres before 1920?
WITH top AS (SELECT
	RANK() OVER (ORDER BY COUNT(movie_id) DESC) ranking,
    genre,
    COUNT(movie_id) total
FROM movies_genres
WHERE movie_id IN (SELECT id FROM movies WHERE year < 1920)
GROUP BY genre
ORDER BY 1)
SELECT ranking, genre, total
FROM top
WHERE ranking <= 5;

-- 4.2 What is the evolution of the top movie genres across all the decades of the 20th century?
select year, count(name) as count from movies  group by year order by count desc;

with genre_count_per_decade as (
select rank() over (partition by decade order by movies_per_genre desc) ranking, genre, decade
from (SELECT 
    genre,
    FLOOR(m.year / 10) * 10 AS decade,
    COUNT(genre) AS movies_per_genre
FROM
    movies_genres mg
        JOIN
    movies m ON m.id = mg.movie_id
GROUP BY decade , genre) as a
)
select genre, decade
FROM genre_count_per_decade
WHERE ranking = 1;

-- Putting it all together: names, genders and time
-- 1. Has the most common name for actors changed over time? Get the most common actor name for each decade in the XX century.
with top as (
SELECT RANK() OVER (PARTITION BY DECADE ORDER BY TOTALS DESC) AS ranking, fullname, totals, decade
from (SELECT concat(a.first_name,' ',a.last_name) as fullname, COUNT(concat(a.first_name,' ',a.last_name)) as totals, FLOOR(m.year / 10) * 10 as decade
FROM actors a
JOIN roles r
	ON a.id = r.actor_id
JOIN movies m
	ON r.movie_id = m.id
GROUP BY decade, concat(a.first_name,' ',a.last_name)) sub)
SELECT decade, fullname, totals
FROM top
WHERE ranking = 1
-- AND decade >= 1900
-- AND decade < 1900
ORDER BY decade;

-- 4. How many movies had a majority of females among their cast? Answer - 50666
SELECT COUNT(movie_title)
FROM (select
  r.movie_id as movie_title,
  count(case when a.gender='M' then 1 end) as male_count,
  count(case when a.gender='F' then 1 end) as female_count
from roles r
JOIN actors a
    ON r.actor_id = a.id
GROUP BY r.movie_id) sub
WHERE female_count > male_count;


-- 5. What percentage of the total movies had a majority female cast? Answer - 
SELECT
(SELECT COUNT(movie_title)
FROM (select
  r.movie_id as movie_title,
  count(case when a.gender='M' then 1 end) as male_count,
  count(case when a.gender='F' then 1 end) as female_count
from roles r
JOIN actors a
    ON r.actor_id = a.id
GROUP BY r.movie_id) sub
WHERE female_count > male_count) / (SELECT COUNT(DISTINCT(movie_id)) FROM roles)