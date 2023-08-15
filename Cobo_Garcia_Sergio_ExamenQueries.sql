USE sakila;

/*EJERCICIO 1*/
SELECT * FROM customer;
SELECT customer.customer_id, "no lloguers"
FROM customer, rental
WHERE customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING count(rental.rental_id) = 0
UNION
SELECT customer.customer_id, "més de 3 lloguers"
FROM customer, rental
WHERE customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING count(rental.rental_id) > 3;

/*EJERCICIO 2*/
SELECT customer.customer_id
FROM customer, rental
WHERE customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING customer.customer_id = ALL (
SELECT customer.customer_id
FROM customer, rental
WHERE year(rental.rental_date) = 2005
GROUP BY customer.customer_id);

/*EJERCICIO 3*/
SELECT * FROM film;
SELECT customer.customer_id, country.country
FROM customer, country, payment, rental, inventory, film
WHERE customer.customer_id = payment.customer_id
AND customer.customer_id = rental.customer_id
AND rental.inventory_id = inventory.inventory_id
AND inventory.film_id = film.film_id
AND max(payment.amount) = (
SELECT max(payment.amount)
FROM payment
WHERE film.title = "ACE GOLDFINGER"
GROUP BY customer.customer_id);

/*EJERCICIO 4*/
SELECT customer.customer_id, country.country
FROM customer, rental, inventory, film, address, city, country
WHERE customer.customer_id = rental.customer_id
AND rental.inventory_id = inventory.inventory_id
AND inventory.film_id = film.film_id
AND customer.address_id = address.address_id
AND address.city_id = city.city_id
AND city.country_id = country.country_id
AND country.country = "Mexico"
GROUP BY customer.customer_id; 

/*EJERCICIO 5*/
SELECT avg(t2.total) as media
FROM (
SELECT count(payment.payment_id) total
FROM payment, customer
WHERE customer.customer_id = payment.payment_id) as t2;

/*EJERCICIO 6*/
SELECT film.film_id, store.store_id, language.name, count(customer.customer_id) as total
FROM store, film, country, customer, inventory, address, city, language
WHERE store.store_id = inventory.store_id
AND inventory.film_id = film.film_id
AND film.original_language_id = language.language_id
AND customer.address_id = address.address_id
AND address.city_id = city.city_id
AND city.country_id = country.country_id
AND country.country = "Mexico"
AND film.original_language_id
GROUP BY customer.customer_id, store.store_id
HAVING total > 30
ORDER BY total DESC;
