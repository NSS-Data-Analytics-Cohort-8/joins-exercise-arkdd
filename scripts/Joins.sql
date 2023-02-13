-- ** How to import your data. **

-- 1. In PgAdmin, right click on Databases (under Servers -> Postgresql 15). Hover over Create, then click Database.

-- 2. Enter in the name ‘Joins’ (not the apostrophes). Click Save.

-- 3. Left click the server ‘Joins’. Left click Schemas. 

-- 4. Right click public and select Restore.

-- 5. Select the folder icon in the filename row. Navigate to the data folder of your repo and select the file movies.backup. Click Restore.


-- ** Movie Database project. See the file movies_erd for table\column info. **

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue 
USING (movie_id)
ORDER BY worldwide_gross ASC;

-- Semi-Tough
-- 2. What year has the highest average imdb rating?

SELECT specs.film_title, specs.release_year,rating.imdb_rating
FROM specs
LEFT JOIN rating
USING (movie_id)
GROUP BY specs.film_title, specs.release_year, rating.imdb_rating 
ORDER BY AVG(imdb_rating) DESC;

--The Dark Knight

-- 3. What is the highest grossing G-rated movie? Which company distributed it?


SELECT *
FROM distributors
JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
JOIN rating
ON specs.movie_id = rating.movie_id
JOIN revenue
ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross DESC;



--Avengers: Endgame

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.


SELECT company_name, COUNT(distributor_id) AS number_of_movies
FROM distributors
JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
JOIN rating
ON specs.movie_id = rating.movie_id
JOIN revenue
ON specs.movie_id = revenue.movie_id
GROUP BY company_name;

--


-- 5. Write a query that returns the five distributors with the highest average movie budget.


SELECT company_name, AVG(worldwide_gross) AS worldwide_gross
FROM distributors
JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
JOIN rating
ON specs.movie_id = rating.movie_id
JOIN revenue
ON specs.movie_id = revenue.movie_id
GROUP BY company_name
ORDER BY worldwide_gross DESC
Limit 5;

-- Top 5 are listed below

"The H Collective"
"Walt Disney "
"Lionsgate"
"Summit Entertainment"
"Icon Productions"


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT *
FROM distributors
JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
JOIN rating
ON specs.movie_id = rating.movie_id
JOIN revenue
ON specs.movie_id = revenue.movie_id
WHERE headquarters <> 'CA'
ORDER BY imdb_rating DESC;


-- There are 419 movies that are made by a company not in CA. The Dark Knight

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT *
FROM distributors
JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
JOIN rating
ON specs.movie_id = rating.movie_id
JOIN revenue
ON specs.movie_id = revenue.movie_id
WHERE headquarters <> 'CA'
ORDER BY imdb_rating DESC;



