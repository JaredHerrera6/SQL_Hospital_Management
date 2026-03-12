/*
 SELECT columns
FROM table
WHERE condition
GROUP BY columns
HAVING condition
ORDER BY columns;
*/

--1 Show patients names with their appointment Dates
SELECT
    p.first_name,
    p.last_name,
    a.appointment_date
FROM patients as p
JOIN appointments as a
on p.patient_id = a.patient_id;

--2 Show doctor name for each appointment 
SELECT 
    d.first_name,
    d.last_name,
    a.*
FROM doctors as d
JOIN appointments as a
on d.doctor_id = a.doctor_id;

--3 Show treatment type with appointment reason 
SELECT
    a.reason_for_visit,
    t.treatment_type
FROM appointments as a
JOIN treatments as t
on a.appointment_id = t.appointment_id

--4 Show patient name with treatment type
SELECT
    p.first_name, 
    p.last_name,
    t.treatment_type
from patients as p
JOIN appointments as a
on p.patient_id = a.patient_id
JOIN treatments as t
on a.appointment_id = t.appointment_id


