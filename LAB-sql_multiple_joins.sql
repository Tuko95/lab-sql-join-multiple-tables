use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

select * from store; -- store_id, address_id
select * from city; -- city_id, city, country_id
select * from country; -- country_id, country
select * from address; -- address_id, city_id

select s.store_id, c.city, co.country from store s
left join address a
using (address_id)
left join city c
using (city_id)
left join country co
using (country_id);



-- 2. Write a query to display how much business, in dollars, each store brought in.

select * from store; -- store_id
select * from staff; -- staff_id, store_id
select * from payment; -- staff_id, amount

select s.store_id, sum(p.amount) as 'business (dollars)' from store s
left join staff st
using (store_id)
left join payment p
using (staff_id)
group by store_id;



-- 3. What is the average running time of films by category?

select * from film; -- film_id, length
select * from film_category; -- film_id, category_id
select * from category; -- category_id, name

select avg(f.length) as 'Length', c.name from film f
left join film_category fa
using(film_id)
left join category c
using(category_id)
group by c.name
order by avg(f.length) desc;



-- 4. Which film categories are longest?

select * from film; -- film_id, length
select * from film_category; -- film_id, category_id
select * from category; -- category_id, name

select avg(f.length) as 'Length', c.name from film f
left join film_category fa
using(film_id)
left join category c
using(category_id)
group by c.name
order by avg(f.length) desc limit 1;

-- 5. Display the most frequently rented movies in descending order.

select * from film; -- title, film_id
select * from rental; -- inventory_id, rental_id
select * from inventory; -- inventory_id, film_id

select f.title, count(r.rental_id) as 'Nº of rents' from film f
left join inventory i
using(film_id)
left join rental r
using(inventory_id)
group by title
order by count(r.rental_id) desc
limit 10;



-- 6. List the top five genres in gross revenue in descending order.

select * from category; -- category_id, name♣ 1
select * from payment; -- amount♣, rental_id 5
select * from film_category; -- category_id, film_id 2
select * from rental;  -- rental_id, inventory_id 4
select * from inventory; -- inventory_id, film_id 3

select c.name, sum(p.amount) as 'total amount' from category c
left join film_category f
using (category_id)
left join inventory i
using (film_id)
left join rental r
using (inventory_id)
left join payment p
using(rental_id)
group by c.name
order by sum(p.amount)desc limit 5;



-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select * from film; -- film_id♥, title♥
select * from inventory; -- inventory_id, film_id, store_id♥

select f.film_id, f.title, i.store_id from film f
left join inventory i
using (film_id)
group by i.store_id
having film_id = 1 and store_id = 1;

# Yes, "Academy Dinosaur" is avalaible for rent from store 1