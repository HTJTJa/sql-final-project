# sql-final-project
Final project for SQL section of the course at MTECH.
Project goals was to find out things I wanted to know about movies using a KAGGLE database. 
The database was structured with 3 tables. A main table IMDB wich then branches to the other two, EARNING and GENRE. The relationship is through the movie_id column in each table. 


-- FROM movie.sqlite database from KAGGLE.
-- Below are query's used for final project. 

//
-- Top 5 profitable movies by genre. 
-- Wanting to see what genre produces the most profitable movies. 

SELECT i.Title, g.genre, e.Domestic, e.Worldwide 
FROM IMDB i JOIN genre g 
	ON i.Movie_id = g.Movie_id 
	JOIN earning e 
	ON g.Movie_id = e.Movie_id 
GROUP BY i.Title 
ORDER BY e.Domestic DESC
LIMIT 5;

-- Of the top 5 films 2 had NULL values in the genre section. The other 3 had "Action" as the listed genre.
-- Based on the movie titles the other two would probably fall under the "Action" genre as well. 
-- The 3 with a genre listed were "Star Wars: The Force Awakens", "Rogue One", and "The Hunger Games: Catching Fire".
-- The 2 without a genre lister were "The Avengers" and "The Dark Knight Rises".\\

//
-- Which out of 10 rating has the most reviews?
-- Wanting to see which rating is the most common by how many people left reviews with that rating.

WITH reviews AS (
	SELECT 
		title,
		cvotes10 AS outof10,
		cvotes09 AS outof9,
		cvotes08 AS outof8,
		cvotes07 AS outof7,
		cvotes06 AS outof6,
		cvotes05 AS outof5,
		cvotes04 AS outof4,
		cvotes03 AS outof3,
		cvotes02 AS outof2,
		cvotes01 AS outof1
	FROM IMDB i 
)
SELECT SUM(outof10) AS total10, 
	SUM(outof9) AS total9, 
	SUM(outof8) AS total8,
	SUM(outof7) AS total7, 
	SUM(outof6) AS total6,
	SUM(outof5) AS total5, 
	SUM(outof4) AS total4,
	SUM(outof3) AS total3, 
	SUM(outof2) AS total2,
	SUM(outof1) AS total1
FROM reviews;

-- The rating category with the most was 8. (13,233,688 votes)
-- The rating category with the least was 2. (178,698 votes)
-- The top 3 categories are 8 (13,233,688 votes), 9 (9,665,869 votes), and 7 (8,089,427 votes).\\


//
-- What kind of average budget do films with a rating between 8 and 9 have? And how many by rating.
-- After seeing that 8 was the most common category chosen I wanted to see the average budgets within the 8 rating scale.
-- And find the rating with the most films and see what the avg_budget is. 

SELECT rating, COUNT(rating) AS num_films, ROUND(AVG(budget), 0) AS avg_budget
FROM IMDB i 
GROUP BY rating
HAVING rating BETWEEN 8 AND 9
ORDER BY budget DESC;

-- Within the 8 rating scale range:
-- 8.1 had the most films at 16 with an avg_budget of $90M.\\


//
-- What is the budget and rating of the movie with the longest runtime?

SELECT title, budget, rating, MAX(CAST(runtime AS interger)) AS runtime_max
FROM IMDB i 
WHERE runtime IS NOT NULL;

-- Answer: "The Wolf of Wall Street" $100M with a rating of 8.2 and a runtime of 180 minutes.\\


//
-- What is the budget and rating of the movie with the shortest runtime?

SELECT title, budget, rating, MIN(CAST(runtime AS interger)) AS runtime_min
FROM IMDB i 
WHERE runtime > 0;

-- Answer: "Gravity" $100M with a rating of 7.8 and a runtime of 91 minutes.
-- I had to do runtime > 0 because there were NULL values and some of the movies had 0 entered as the runtime.\\



-- INSIGHTS FROM QUERY'S
-- From a visual perspective the budget for higher rated films was within the $80M to $100M range. 
-- I was not expecting for 8 to the most common rating. 
-- I was also not expecting to see some of the runtimes listed at 0 instead of being left NULL values. 
-- One of the things I noticed is that it seemed that a movie being long doesn't affect the rating in a major way.


