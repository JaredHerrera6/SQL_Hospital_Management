/*
 SELECT columns
FROM table
WHERE condition
GROUP BY columns
HAVING condition
ORDER BY columns;
*/
-- Count total patients
SELECT
    COUNT(*)
FROM patients;
-- There are a total of 50 patients

--Count Doctors by specialization
SELECT 
    COUNT(*) total_doctors,
    specialization
from doctors
GROUP BY specialization;
/*
Totals: Pediatrics(5), Dermotology(3), Oncology(2)
*/

--Find the average treatment cost
SELECT 
    ROUND(AVG(COST),2) AS average_cost
FROM treatments;
--The average treatment cost is $2756.25

-- Find the total hospital revenue from bills
SELECT 
    sum(amount) as total_amount
FROM bills;
--The total hospital revenue amount is $551249.85

--Count appointments by status 
SELECT
    status,
    Count(*) as total
FROM appointments
GROUP BY status
ORDER BY total DESC;
-- No-show(52), Scheduled(51), Cancelled(51), Completed(46)


