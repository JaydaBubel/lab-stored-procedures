use sakila

-- 1: create a stored procedure to retrieve customer information for a specific movie category
delimiter //
create procedure getcustomersbymoviecategory()
begin
    select c.first_name, c.last_name, c.email
    from customer c
    join rental r on c.customer_id = r.customer_id
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
    join film_category fc on f.film_id = fc.film_id
    join category cat on fc.category_id = cat.category_id
    where cat.name = "Action"
    group by c.first_name, c.last_name, c.email;
end //
delimiter ;

-- 2: call stored procedure to retrieve customers who rented movies in the "Action" category
call getcustomersbymoviecategory();

-- 3: create stored procedure to find movie categories with a movie count greater than a specified threshold
delimiter //
create procedure findcategorieswiththreshold(in threshold int)
begin
    select c.name, count(fc.film_id) as movie_count
    from film_category fc
    left join category c on fc.category_id = c.category_id
    group by c.name
    having movie_count > threshold;
end //
delimiter ;

-- 4: call stored procedure to find categories with a movie count greater than 50
call findcategorieswiththreshold(50);