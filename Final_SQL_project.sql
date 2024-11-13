SELECT *
FROM earning 

SELECT *
FROM imdb

SELECT *
FROM genre

-- Top 5 profitable movies by genre

SELECT i.Title, g.genre, e.Domestic, e.Worldwide 
FROM IMDB i JOIN genre g 
	ON i.Movie_id = g.Movie_id 
	JOIN earning e 
	ON g.Movie_id = e.Movie_id 
GROUP BY i.Title 
ORDER BY e.Domestic DESC
LIMIT 5;


-- Which out of 10 rating has the most reviews

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


-- What kind of budgets do films with a rating between 8 and 9 have? And how many by rating.

SELECT rating, COUNT(rating) AS num_films, ROUND(AVG(budget), 0) AS avg_budget
FROM IMDB i 
GROUP BY rating
HAVING rating BETWEEN 8 AND 9
ORDER BY budget DESC;


-- What is the budget and rating of the movie with the longest runtime?

SELECT title, budget, rating, MAX(CAST(runtime AS interger)) AS runtime_max
FROM IMDB i 
WHERE runtime IS NOT NULL;

-- What is the budget and rating of the movie with the shortest runtime?

SELECT title, budget, rating, MIN(CAST(runtime AS interger)) AS runtime_min
FROM IMDB i 
WHERE runtime > 0;

