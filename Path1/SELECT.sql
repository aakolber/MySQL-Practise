USE SAKILA;

-- 1. Select the 10 cheapest movies
SELECT title, price FROM FILM_LIST 
ORDER BY price DESC
LIMIT 10;

-- 2. Select the 5 shortest movies
SELECT title, length FROM FILM_LIST 
ORDER BY length ASC
LIMIT 5;

-- 3. Find largest value and name of sales by category
SELECT category, (SELECT MAX(total_sales) FROM SALES_BY_FILM_CATEGORY) AS MAX_VALUE FROM SALES_BY_FILM_CATEGORY 
WHERE total_sales = (SELECT MAX(total_sales) FROM SALES_BY_FILM_CATEGORY);

-- 4. Select all movies where plays WARREN NOLTE
SELECT title, actors FROM FILM_LIST
WHERE actors LIKE "%WARREN NOLTE%";

-- 5. Find name and surname custobers by payment

SELECT first_name, last_name, amount, payment_date 
FROM CUSTOMER, PAYMENT 
WHERE CUSTOMER.customer_id = PAYMENT.customer_id;

-- 6. Find average cost of Drama film 
SELECT AVG(replacement_cost) AS Drama_average_price
FROM FILM, FILM_CATEGORY, CATEGORY 
WHERE FILM.film_id = FILM_CATEGORY.film_id AND 
CATEGORY.category_id = FILM_CATEGORY.category_id AND 
name = 'Drama';

-- 7. Find average cost of every category
SELECT ROUND(AVG(replacement_cost),2) AS average, name
FROM FILM, FILM_CATEGORY, CATEGORY 
WHERE FILM.film_id = FILM_CATEGORY.film_id AND 
CATEGORY.category_id = FILM_CATEGORY.category_id 
GROUP BY name;

-- 8. How many movies have the actors played in?
SELECT COUNT(film_id) AS FILM_COUNTER, first_name, last_name
FROM FILM_ACTOR
JOIN ACTOR ON ACTOR.actor_id = FILM_ACTOR.actor_id
GROUP BY first_name, last_name;


-- 9. Find full address  of customer 
SELECT first_name, last_name, address, postal_code, city, country FROM CUSTOMER, ADDRESS, CITY, COUNTRY
WHERE CUSTOMER.address_id = ADDRESS.address_id AND ADDRESS.city_id = CITY.city_id AND CITY.country_id = COUNTRY.country_id;

-- 10. Find the number of cities from each country
SELECT COUNT(city_id), country
FROM city
JOIN country ON CITY.country_id = COUNTRY.country_id
GROUP BY country
ORDER BY COUNT(city_id) DESC;

-- 11. Account lifetime
SELECT first_name, TIMESTAMPDIFF (YEAR, create_date, CURDATE()) AS lifetime 
FROM CUSTOMER;
