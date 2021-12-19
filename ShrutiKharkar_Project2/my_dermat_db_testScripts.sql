-- Supporting Functionality scripts Operations on the my_dermat_db 

-- 1. Retrieving the data in the staff table
select * from staff; -- returns 9 rows

-- 2. Retrieving the row for the patient with last name as 'Malone'
select * from patient where patient_lname = 'Malone'; -- returns 1 row

-- 3. Retreiving the row for the list of Consulting doctor
select * from staff where designation = 'Consutling Doctor'; -- return 2 rows

-- 4. Retreving the data for the staff whose first name starts with 'S'
select * from staff where first_name like 'S%'; -- return 3 rows

-- 5. Retrieving the data of full name of the patient -- return 10 rows
select concat(p1.patient_fname," ",p2.patient_lname) as 'Patient full name'
from patient p1, patient p2
where p1.patient_id=p2.patient_id;

-- 6. Retrieving the list of patient id and name along with the insurance detail, whose insurance plan is ISO 
select p3.patient_id,p3.patient_fname,p3.patient_lname, i.Insurance_id, i.In_provider, i.In_plan_name
from patient p3, insurance i
where p3.insurance_id= i.insurance_id 
and i.In_provider = 'ISO';

-- 7. Retreiving the data for patient details: full name, id and phone number who visited the doctor on 2021-10-28
select p1.patient_id, concat(patient_fname," ",patient_lname) as patient_Fullname,
p1.phone,a1.appointment_id, a1.start_time
from appointment a1 join patient p1 
where a1.patient_id=p1.patient_id
and a1.start_time like '2021-10-28%'; 

-- 8.Retrieving the data for the number of appointment for each doctor 
SELECT COUNT(a1.doc_id) as numberOfAppointments, concat(s1.first_name," ",s1.last_name) as doctor_name
FROM appointment a1, staff s1
where a1.doc_id=s1.staff_id
GROUP BY doc_id, doctor_name 
ORDER BY COUNT(doc_id) asc;

-- 9. Retreiving the data for the patient who have been given certain diagnosis and medicine for that dianosis
select d1.diagnosis_id, d1.patient_id, concat(p1.patient_fname," ",p1.patient_lname) as patient_name,
d1.treatment as Diagnosis, m1.medicine_id
from patient_diagnosis d1 join patient p1 join medication m1
where d1.patient_id = p1.patient_id
and d1.diagnosis_id = m1.diagnosis_id;

-- 10. Retreiving the data for patient undergoing a test/procedure and the person performed the procedure
SELECT CONCAT(p1.patient_fname, " ", p1.patient_lname) as patient_name,t2.name as procedureName, 
t1.doc_id, concat(first_name," ",last_name) as performedBy
FROM patient p1
left JOIN appointment a1 ON p1.patient_id=a1.patient_id
left JOIN staff s1 ON a1.doc_id=s1.staff_id
left JOIN Patient_test t1 ON t1.appointment_id = a1.appointment_id
left JOIN test_avail t2 ON t2.test_id = t1.procedure_code
where p1.patient_id = '13';

-- 11. Retreiving the data for patient undergoing a specific test/procedure and the person performed the procedure
SELECT CONCAT(p1.patient_fname, " ", p1.patient_lname) as patient_name,t2.name as procedureName, 
t1.doc_id, concat(first_name," ",last_name) as performedBy
FROM patient p1
left JOIN appointment a1 ON p1.patient_id=a1.patient_id
left JOIN staff s1 ON a1.doc_id=s1.staff_id
left JOIN Patient_test t1 ON t1.appointment_id = a1.appointment_id
left JOIN test_avail t2 ON t2.test_id = t1.procedure_code
where t2.test_id='100005';

-- 12. Retreving the test results of the patient who has undergone certain test/procedure
SELECT CONCAT(p1.patient_fname, " ", p1.patient_lname) as patient_name,t2.name as procedureName, 
t1.doc_id, concat(first_name," ",last_name) as performedBy, r1.test_result
FROM patient p1
left JOIN appointment a1 ON p1.patient_id=a1.patient_id
left JOIN staff s1 ON a1.doc_id=s1.staff_id
left JOIN Patient_test t1 ON t1.appointment_id = a1.appointment_id
left JOIN test_avail t2 ON t2.test_id = t1.procedure_code
left join patient_results r1 on r1.procedure_id=t1.procedure_id
where t2.test_id='100001';

-- 13. Retreiving the data for a patient diagnosis and his medicine prescribed by the doctor
select p1.diagnosis_id, p1.patient_id, p1.Treatment as 'DiagnosisDone', 
m1.medicine_id,m2.name as 'Medicine prescirbed', 
m1.med_dose as 'TakenNoOfDays' 
from patient_diagnosis p1 left join medication m1 on p1.diagnosis_id = m1.diagnosis_id
left join medicine_avail m2 on m2.medicine_id=m1.medicine_id
where patient_id = '16';

-- 14. Retreiving the data for a patient diagnosis and his medicine prescribed by the doctor and the doctor who prescribed it.
select p1.diagnosis_id, p1.patient_id, p1.Treatment as 'DiagnosisDone', 
m1.medicine_id,m2.name as 'Medicine prescirbed',concat(s1.first_name," ",s1.last_name) as 'DoctorName',
m1.med_dose as 'TakenNoOfDays' 
from patient_diagnosis p1 left join medication m1 on p1.diagnosis_id = m1.diagnosis_id
left join medicine_avail m2 on m2.medicine_id=m1.medicine_id
left join appointment a1 on a1.appointment_id=m1.appointment_id
left join staff s1 on s1.staff_id=a1.doc_id
where p1.patient_id = '19';

-- 15. Retreiving the data for the patient who visited the clinic atleast twice
SELECT CONCAT(p1.patient_fname, " ", p1.patient_lname) as patient_name, count(a1.patient_id) "NumberofAppointments"
FROM appointment a1
JOIN patient p1 ON p1.patient_id = a1.patient_id
GROUP BY p1.patient_fname
HAVING count(a1.doc_id)>=2;


-- 16. To check if a particular medicine is present in the medicine inventory using its name
SELECT EXISTS(SELECT * from medicine_avail WHERE name like '%steriod%') as '0 if medNotAvail/ 1 if medAvail'; -- Present in the inventory
SELECT EXISTS(SELECT * from medicine_avail WHERE name like '%paracetamol%') as '0 if medNotAvail/ 1 if medAvail'; -- not present in the inventory

-- 17. Retrieving the patient data who is suffering from various symptoms for his condition
select  concat(p1.patient_fname," ",p1.patient_lname)as 'patientName',s1.* from patient_symptoms s1 join appointment a1 on s1.appointment_id=a1.appointment_id
join patient p1 on p1.patient_id=a1.patient_id
where p1.patient_id = '12';

/*
-- 18. Retrieving the details of list of patients who has Paid the clinic bill using insurance
select a1.appointment_id,p2.patient_id,p1.payment_id,p1.payment_method,p1.payment_total,p1.payment_date from appointment a1 join payment p1 on a1.appointment_id=p1.appointment_id
join patient p2 on p2.patient_id=a1.patient_id
where payment_method = '';
*/

-- 19. update statment for medication for updating the medicine dose
update medication
set med_dose= 7
where medicine_id = '100';

-- 20. update statement for payment table for updating payment method and payment amout
update payment
set payment_method = 'Cash', payment_total='550'
Where Payment_id = '10999943' ;

-- 21. Delete statement for deleting patient_symptoms
delete from patient_symptoms where appointment_id = '1008';

-- 22. Creating a function to return age of the patient using their dob 
DROP FUNCTION IF EXISTS ageInYears
DELIMITER //
CREATE FUNCTION ageInYears(date1 date) RETURNS int DETERMINISTIC
BEGIN
 DECLARE date2 DATE;
  Select current_date()into date2;
  RETURN year(date2)-year(date1);
END //
DELIMITER ;
-- testing the data using below query 
select patient_id, patient_fname, patient_lname, ageInYears(patient_dob) as 'Age' from patient;

-- 23. Using with clause to retrieve the data for the employees who have the designation 'Medical Receptionist'
WITH employees AS (  
    SELECT * FROM staff WHERE designation = 'Medical Receptionist'   
    )   
    SELECT staff_id, first_name,designation FROM employees  
    ORDER BY staff_id; 

-- 24. Retrieving the count of specific procedures completed in the clinic
SELECT COUNT(tp.test_id) as 'Test id', tp.name as 'Test name'
FROM patient p
JOIN appointment a ON p.patient_id=a.patient_id
JOIN staff e ON a.doc_id=e.staff_id
JOIN Patient_test pp ON pp.appointment_id = a.appointment_id
JOIN Test_avail tp ON tp.test_id = pp.procedure_code group by tp.name;

-- 25. to test the user profiles and role based acceess for doctor_staff:
update patient set patient_fname = 'Jimmy' where patient_id = '11'; -- fail as no access given
select * from test_Avail; -- fail as no access given
call patientSymptoms(11); -- success as the access is given










