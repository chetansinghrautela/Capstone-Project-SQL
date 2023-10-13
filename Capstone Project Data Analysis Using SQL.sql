use sakila;
--  Task 1) Display the full names of actors available in the database.
select first_name,last_name,concat(first_name,' ',last_name) as Full_Name from actor; 

-- Task 2.1)Display the number of times each first name appears in the database.
select first_name,count(first_name) from actor
group by first_name
order by count(first_name) desc;

-- Task 2.2)What is the count of actors that have unique first names in the database? Display the first names of all these actors.
select first_name from actor
group by  first_name
having count(*) = 1;

-- Task 3.1)Display the number of times each last name appears in the database.
select last_name,count(last_name) from actor
group by last_name
order by count(last_name) desc;

-- Task 3.2)Display all unique last names in the database.
select last_name from actor
group by last_name
having count(*) =1;




-- Task 4.1)Display the list of records for the movies with the rating "R". (The movies with the rating "R" are not suitable for audience under 17 years of age.)
select title,rating from film 
where rating = "R";

-- Task 4.2)Display the list of records for the movies that are not rated "R".
select title , rating from film 
where rating!="R";

-- Task 4.3)Display the list of records for the movies that are suitable for audience below 13 years of age.
select title,rating,replacement_cost,rental_rate from film 
where rating ="PG-13";
select * from film;


-- Task5.1) Display the list of records for the movies where the replacement cost is up to $11.
select title,replacement_cost,rating,length,rental_duration from film
where replacement_cost <=11
order by replacement_cost desc;

-- Task 5.2) Display the list of records for the movies where the replacement cost is between $11 and $20.
select title,replacement_cost,rating,length,rental_duration from film
where replacement_cost between 11 and 20;

-- Task 5.3) Display the list of records for all the movies in descending order of their replacement costs.
select title,replacement_cost,rating,length,rental_duration from film
order by replacement_cost desc;

-- Task 6) Display the names of the top 3 movies with the greatest number of actors.
select title, count(first_name) as Total_Actor from film 
join film_actor
on film.film_id = film_actor.film_id
join actor
on film_actor.actor_id = actor.actor_id
group by title
order by count(first_name) desc
limit 3;

-- Task 7)'Music of Queen' and 'Kris Kristofferson' have seen an unlikely resurgence. As an unintended consequence, films starting with the letters 'K' and 'Q' have also soared in popularity. 
-- Display the titles of the movies starting with the letter 'K' and 'Q'.
select title from film
where title like 'K%' or title like'Q%';

-- Task 8) The film 'Agent Truman' has been a great success. Display the names of all actors who appeared in this film.
select title, concat(first_name,' ',last_name) as Full_name from film
join film_actor
on film.film_id = film_actor.film_id
join actor
on film_actor.actor_id = actor.actor_id
where title = 'Agent Truman';

-- Task 9) Sales have been lagging among young families, so the management wants to promote family movies. Identify all the movies categorized as family films.
select title, name from film
join film_category
on film.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
where name = 'Family';

-- Task 10.1)Display the maximum, minimum and average rental rates of movies based on their ratings. The output must be sorted in descending order of the average rental rates.
select rating,avg(rental_rate) as Average_Rental_Rate,max(rental_rate) as Maximum_Rental_Rate,min(rental_rate) as Minimum_Rental_Rate from film
group by rating;

-- Task 10.2)Display the movies in descending order of their rental frequencies, so the management can maintain more copies of those movies.
select title,rental_rate from film
order by rental_rate desc;

-- Task 11.1) In how many film categories, the difference between the average film replacement cost (disc-DVD/Blue Ray) and the average film rental rate is greater than $15?
select title,(avg(replacement_cost)-avg(rental_rate)) as Differece from film 
group by title
having (avg(replacement_cost)-avg(rental_rate))>=15;


-- Task 11.2) Display the list of all film categories identified above, along with the corresponding average film replacement cost and average film rental rate.
select title,avg(replacement_cost),avg(rental_rate),(avg(replacement_cost)-avg(rental_rate)) as Difference from film 
group by title
having (avg(replacement_cost)-avg(rental_rate))>=15
order by (avg(replacement_cost)-avg(rental_rate)) desc;

-- Task 12)Display the film categories in which the number of movies is greater than 70.
select name,count(title) from film 
join film_category
on film.film_id= film_category.film_id
join category
on film_category.category_id = category.category_id
group by name
having count(title) >70;
