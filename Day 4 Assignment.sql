=====================================================
DAY 04 ASSIGNMENT: PostgreSQL JOINS (dvdrental)
=====================================================
Instructions:
Write SQL queries to solve the problems below.
Use proper formatting and comments.


-----------------------------------------------------
Q1: List all customers along with their total payment amount.
Output: customer_id, full_name, total_amount

SELECT c.customer_id, 
	CONCAT(first_name, ' ', last_name) as full_name, 
	SUM(p.amount) as total_amount
FROM customer c
LEFT JOIN payment p 
	ON c.customer_id = p.customer_id
GROUP BY c.customer_id, full_name

----------------------------------------------------
Q2: Retrieve the top 10 customers by total amount spent.
Output: full_name, email, total_amount
-- answer
SELECT CONCAT(first_name, ' ', last_name) as full_name, 
	email,
	SUM(p.amount) as total_amount
FROM customer c
LEFT JOIN payment p 
	ON c.customer_id = p.customer_id
GROUP BY full_name, email
ORDER BY total_amount DESC
LIMIT 10

-----------------------------------------------------
Q3: Display all films and their corresponding categories.
Tables: film, film_category, category
SELECT title,
	c.name as category
FROM film f
LEFT JOIN film_category fc
	ON f.film_id = fc.film_id
LEFT JOIN category c
	ON fc.category_id = c.category_id
----------------------------
Q4: Find the number of rentals made by each customer.
Output: customer_id, full_name, total_rentals

SELECT c.customer_id,
	CONCAT(first_name, ' ', last_name) as full_name,
	count(r.rental_id) as total_rentals
FROM customer c
LEFT JOIN rental r
	ON c.customer_id = r.customer_id
GROUP BY c.customer_id
-----------------------------------------------------
Q5: List customers who have never made a payment.
Hint: LEFT JOIN
--answer
SELECT 
	DISTINCT(C.customer_id),
	CONCAT(first_name, ' ', last_name) as full_name
FROM 
	customer c
LEFT JOIN
	payment p
ON 
	c.customer_id = p.customer_id
WHERE 
	p.customer_id IS NULL;


-----------------------------------------------------
Q6: Show total revenue generated per store.
Tables: store, staff, payment
SELECT
	st.store_id,
	SUM(p.amount) as total_revenue
FROM 
	store st
LEFT JOIN 
	staff s
ON 
	st.store_id = s.store_id
LEFT JOIN
	payment p
	ON s.staff_id = p.staff_id
GROUP BY 
	st.store_id

-----------------------------------------------------
Q7: Identify the top 5 most rented movies.
Output: film_title, rental_count
-- answer
SELECT 
	title as film_title,
	COUNT(rental_id) as rental_count
FROM film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY film_title
ORDER BY rental_count DESC
LIMIT 5


-----------------------------------------------------
Q8 (BONUS): Find customers who rented more than 30 films.
Output: full_name, rental_count
SELECT
	CONCAT(first_name, ' ', last_name) as full_name,
	COUNT(rental_id) as rental_count
FROM customer c
LEFT JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY full_name
HAVING COUNT(rental_id) > 30