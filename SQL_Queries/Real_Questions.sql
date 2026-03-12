/*
 SELECT columns
FROM table
WHERE condition
GROUP BY columns
HAVING condition
ORDER BY columns;
*/


--1 Doctor with the most appointments
SELECT
    d.doctor_id,
    d.first_name,
    d.last_name,
    Count(a.*) as number_appointments
FROM doctors as d
JOIN appointments as a
on d.doctor_id = a.doctor_id
GROUP BY 
    d.doctor_id,
    d.first_name,
    d.last_name
ORDER BY number_appointments DESC
--Dr.Sarah Taylor has the most appointments with 29


--2 MOST Common Treatment 
SELECT
    t.treatment_type,
    COUNT(a.*) as treatment_count
FROM appointments as a
JOIN treatments as t
ON a.appointment_id = t.appointment_id
GROUP BY
    t.treatment_type
ORDER BY treatment_count DESC

-- The most Common Treament Type is Chemotherapy with 49 occurences

--3 Total revenue by payment status
SELECT 
    payment_status,
    SUM(amount) as total_revenue
from bills
GROUP BY payment_status
ORDER BY total_revenue DESC;
-- Failed: $193212.94
-- Pending: $184612.01
-- Paid: $173424.90

--4 Average treatment cost by treatment type
SELECT 
    treatment_type,
    ROUND(AVG(cost),2) as average_cost
FROM treatments
GROUP BY treatment_type
ORDER BY average_cost DESC 
/*
Average cost for each treatment type
MRI: $3224.95
Physiotherapy: $2761.61
X-ray: $2698.87
Chemotherapy: $2629.71
ECG: $2532.22
*/

--5 Patients who had MRI treatments
SELECT 
    p.first_name,
    p.last_name,
    p.patient_id
FROM patients as p
JOIN appointments as a
on p.patient_id = a.patient_id
JOIN treatments as t
on a.appointment_id = t.appointment_id
where t.treatment_type = 'MRI'
GROUP by 
    p.patient_id,
    p.first_name,
    p.last_name

    
--6 3 most expensive treatements
SELECT  
    *,
    RANK() OVER (ORDER BY cost DESC) as cost_rank
from treatments
LIMIT  3
/*
The 3 most expensive treatments were
T108:$4973.63
T130:$4966
T156:$4964.71
*/

--7 Most expensive treatment
SELECT
    *,
    RANK() OVER (ORDER BY cost DESC) as cost_rank
from treatments
LIMIT 1
--The most expensive treatment was for an xray

--8 Total Revenue by Doctor
SELECT
    d.doctor_id,
    d.first_name,
    d.last_name,
    SUM(t.cost) as total_revenue
from doctors as d 
JOIN appointments as a
on d.doctor_id = a.doctor_id
JOIN treatments t 
on a.appointment_id = t.appointment_id
GROUP BY 
    d.doctor_id,
    d.first_name,
    d.last_name
ORDER BY total_revenue DESC;


--9 Patients with Multiple Appointments
SELECT
    p.first_name,
    p.last_name,
    count(a.appointment_id) as times_visited
FROM patients as p
JOIN appointments as a
on p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(appointment_id) > 1
ORDER BY times_visited

--10 Most common treatment
SELECT
    treatment_type,
    count(treatment_id) as treatment_count
FROM treatments
GROUP BY treatment_type
ORDER BY treatment_count DESC
LIMIT 1
-- The most common treatment is CHemotyherapy with 49 treatment occurences 

--11 Doctors who have never had an appointment 
SELECT d.first_name,d.last_name 
FROM doctors as d
LEFT JOIN appointments as a
on d.doctor_id = a.doctor_id
where a.appointment_id IS NULL
--All of the doctors have had an appointment 

--12 Revenue by payment method
select 
    payment_method,
    SUM(amount) as total_revenue
from bills
GROUP BY payment_method
ORDER BY total_revenue DESC
-- Credit Card: $201,382.43
-- Insurance: 182160.28
-- Cash 167707.14

--13 Average Treament Cost Per Doctor
select
    d.doctor_id,
    d.first_name,
    d.last_name,
    ROUND(AVG(t.cost),2) average_treatment_cost
from doctors d
JOIN appointments a 
on d.doctor_id = a.doctor_id
JOIN treatments as t 
on a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY average_treatment_cost DESC

--14 Find which hospital branch has the most doctors
SELECT
    hospital_branch,
    COUNT(*) as total_doctors
FROM doctors
GROUP BY hospital_branch
order BY total_doctors DESC
LIMIT 1;
-- Central Hospital Branch has the most with a total of 4 doctors

--15 Find the most recent appointment Per Patient
SELECT
    p.first_name,
    p.last_name,
    a.appointment_date
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY patient_id
               ORDER BY appointment_date DESC
           ) AS rn
    FROM appointments
) a
JOIN patients p
ON p.patient_id = a.patient_id
WHERE rn = 1;

--16 Average treatment Cost by treatment type
SELECT
    treatment_id,
    treatment_type,
    cost,
    AVG(cost) OVER (PARTITION BY treatment_type) AS avg_cost
FROM treatments;
--Shows the cost of each treatment compared to the average cost of the treatment type

--Shows the AVG cost of each treatment type 
SELECT 
    treatment_type,
    AVG(cost)
from treatments
GROUP BY treatment_type
