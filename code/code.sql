/*
Chapter 5 Assignment: How to insert, update, and delete data
Name: Clay Rasmussen
Date: 10/23/26
*/

/*
Clay Rasmussen
Query 1
Part 1.1) Write a query that determines how many records are in the customer table, and document
Part 1.2) Write a statement that creates a complete backup table for the customer table
Part 1.3) Write a query that verifies your newly created backup table has the same number of rows as the
original table
Part 1.4) Use the MySQL CHECKSUM to verify the two tables are the same
*/
/*Part 1.1*/
SELECT * FROM customer; -- 599 returned
SELECT count(*) FROM customer;

/*Part 1.2*/
CREATE TABLE customer_full_backup AS
	SELECT * FROM customer;

/*Part 1.3*/
CHECKSUM TABLE customer, customer_full_backup;

/*
Exercise 2
Part 2.1 Write 3 queries to determine the following
	a. how many records are in the rental table
    b. how many rentals have been returned bases on return_date, and document
    c. how many rentals have NOT been returned bases on return_date, and document
2.2 Write statements to create a partial backup of the rental table for all rentals that have been returned. Name you backup table returned_rental
*/
/*2.1a*/
SELECT count(*) FROM rental; -- 16044  

/*2.1b*/
SELECT * FROM rental
WHERE return_date IS NOT NULL;

/*2.1c*/
SELECT * FROM rental
WHERE return_date IS NULL;

/*2.2*/
CREATE TABLE returned_rental AS
	SELECT * FROM rental
    WHERE return_date IS NOT NULL;

/*
Exercise 3
Write one or two statements that will drop the backup tables form Excercise 1 and 2
*/
DROP TABLE `if26clayr_sakila`.`returned_rental`;
DROP TABLE `if26clayr_sakila`.`customer_full_backup`;

/* 
Excercise 4
4.1 Write multiple statements to setup youself as a new customer with a new city and new addresss
	use DEFAUT for auto increment colums
	use NULL for columns that allow null values
    use DEFAULT for columns with default values
*/
/* City Insert */
INSERT INTO city
	(city_id, city, country_id, last_update)
VALUES
	(DEFAULT, 'Kearney', 103, NULL);
    
/* Address Insert */
INSERT INTO address
	(address_id, address, address2, district, city_id, postal_code, phone, last_update)
VALUES
	(601, 'Kearney', 103, NULL)
WHERE city_id = 601;









