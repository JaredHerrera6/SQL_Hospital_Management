/*
 SELECT columns
FROM table
WHERE condition
GROUP BY columns
HAVING condition
ORDER BY columns;
*/

--1 Show all patients
SELECT *
FROM patients;

--Show only patient names and emails
SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM patients;

--Find all doctors. who specialize in Pediatrics
SELECT DISTINCT
    *
FROM doctors
where specialization = 'Pediatrics';

--Show all appointments that were cancelled
SELECT 
    *
FROM    
    appointments
WHERE
    status = 'Cancelled';

--Find the treatments that cost more than $4000
SELECT 
    * 
FROM 
    treatments
WHERE cost > 4000
ORDER BY cost DESC;

