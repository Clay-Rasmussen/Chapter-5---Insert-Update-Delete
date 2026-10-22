/*
Chapter 5 Assignment: How to insert, update, and delete data
Name: Clay Rasmussen
Date: 10/22/26
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
-- Part 1.1
SELECT * FROM customer; -- 601 returned
SELECT count(*) FROM customer;

-- Part 1.2
CREATE TABLE customer_full_backup AS
	SELECT * FROM customer;

-- Part 1.3
CHECKSUM TABLE customer, customer_full_backup;

/*
Exercise 2
Part 2.1 Write 3 queries to determine the following
	a. how many records are in the rental table
    b. how many rentals have been returned bases on return_date, and document
    c. how many rentals have NOT been returned bases on return_date, and document
2.2 Write statements to create a partial backup of the rental table for all rentals that have been returned. Name you backup table returned_rental
*/
-- 2.1a
SELECT count(*) FROM rental; -- 16044  

-- 2.1b
SELECT * FROM rental
WHERE return_date IS NOT NULL;

-- 2.1c
SELECT * FROM rental
WHERE return_date IS NULL;

-- 2.2
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
-- City Insert
INSERT INTO city
VALUES
	(DEFAULT, 'Kearney', 103, NULL);
    
-- City insert verification
SELECT *
FROM city
WHERE city = 'Kearney';

-- Address Insert
INSERT INTO address
VALUES
	(DEFAULT, '4507 Ridgeline Rd', NULL, 'NE', '601', '68845', '3083403915', DEFAULT );

-- Address insert verification
SELECT *
FROM address
WHERE city_id = '601';

-- Customer Insert
INSERT INTO customer
VALUES
	(DEFAULT, 1, 'Clay', 'Rasmussen', 'clrasm02@wsc.edu', 606, DEFAULT, NULL, NULL);
    
-- customer insert verification
SELECT *
FROM customer
WHERE address_id = 606;

/*
Exercise 5: Insert statement using a column list
• Part 5.1: Write a statement to setup insert another new customer with the same address id 606
	Also use the same last name as the previous insert statement
	OMIT all columns that are auto increment, defaults, and nullable columns
• Part 5.2: Write a query to prove the new customer was created by filtering on address id 606
    This should have created customer id = 601
*/
-- customer replace
INSERT INTO customer 
	(store_id, first_name, last_name, address_id)
VALUES
	(1, 'Mac', 'Rasmussen', 606);
    
-- customer replace verification
SELECT *
FROM customer
WHERE address_id = 606;

/*
Exercise 6: Update multiple columns for a single record
Note: use book_scripts/ch05/5-05 examples as a starting point
Write the following update statements:
• Part 6.1 - update your first new customer record by changing it's store id = 2 and email address
use the customer id (600) to update only one record
• Part 6.2 - update your second new customer record by changing it's store id = 2 and email address
use the customer id (601) to update only one record
• Part 6.3 - write a query to verify the two records have been correctly update
use the address id (606) to retrieve both records
*/
-- first new customer update
UPDATE customer
SET
	store_id = 2, email = 'clay.rasmussen@wsc.edu'
WHERE customer_id = 602;

-- second new customer update
UPDATE customer
SET
	store_id = 2, email = 'giex@gixlogistics.com'
WHERE customer_id = 603;

-- two query verifications
SELECT *
FROM customer
WHERE address_id = 606;

/*
Exercise 7: Update multiple records (rows)
• Part 7.1: Write one update statement that will update both new customer records
changing their address id from 606 to 605. This will require you filtering by the address id = 606.
• Part 7.2: Write a query to verify that both records have been correctly updated by filtering by address id (605)
*/
-- update customer records from 606 to 605
UPDATE customer
SET address_id = 605
WHERE address_id = 606;

-- 7.2.1 validation of record update
SELECT *
FROM customer
WHERE address_id = 605;

-- 7.2.2 Debbie would this be a more specific validation method so we dont get the bonus 599 record?
SELECT *
FROM customer
WHERE customer_id IN (600, 601)
	AND address_id = 605;
    
/*
  Exercise 8: Write delete statements
Note: use book_scripts/ch05/5-07 examples as a starting point
• Part 8.1.A - Write a delete statement that delete the new city records using the city id = 601
• Part 8.1.B - Write a delete statement that delete the new address records using the address id = 606
• Part 8.1.C - Write a delete statement that delete the new customer records using the customer id = 600 & 601
• Part 8.2 - Write a queries that verifies the records has been deleted.
• Part 8.3 - Document your results and what you had to do to resolve the issue.  
*/
-- 8.1a
DELETE FROM address
WHERE city_id = 601;

-- 8.1b
DELETE FROM address
WHERE address_id = 606;

-- 8.1c
DELETE FROM customer
WHERE customer_id IN (600, 601);

-- 8.2
SELECT * 
FROM customer
WHERE customer_id IN (600, 601);

SELECT *
FROM address
WHERE address_id = 606;

SELECT *
FROM city
WHERE city_id = 601;

-- 8.3
/*
You have to respect foreign key restraints. A city cannor be delete while an address references it, and
an address cannot be referenced if a customer refers to it. You must delete them in a reverse order so 
as to avoid having stray records that don't access a real value.  
*/

