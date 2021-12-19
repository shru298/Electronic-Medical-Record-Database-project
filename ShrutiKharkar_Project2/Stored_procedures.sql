USE my_dermat_db;

-- Procedures
###############################################################################################################################333
-- Inserting stored procedures
#################################################################################################################################
-- Inserting data in test_avail table using procedure
DROP PROCEDURE IF EXISTS TestAvailInsert;
DELIMITER //
CREATE PROCEDURE TestAvailInsert
(test_id Integer, name VARCHAR(100), description VARCHAR(200), price INTEGER)
BEGIN
  INSERT INTO test_Avail(test_id, name, description, price)
  VALUE(test_id, name, description, price);
END//
DELIMITER ;

-- procedure for inserting staff data in staff table
DROP PROCEDURE IF EXISTS StaffInsert;
DELIMITER //
CREATE PROCEDURE StaffInsert
(Staff_id Integer, personal_identification_number integer, first_name VARCHAR(50), last_name VARCHAR(50), email_id VARCHAR(50), designation VARCHAR(50), salary DECIMAL(9, 2 ))
BEGIN
  INSERT INTO staff(Staff_id, personal_identification_number, first_name, last_name, email_id, designation, salary )
  VALUES (Staff_id, personal_identification_number, first_name, last_name, email_id, designation, salary );
END//
DELIMITER ;

-- procedure for inserting data into medication table
DROP PROCEDURE IF EXISTS insert_medicaiton;
DELIMITER //
CREATE PROCEDURE insert_medicaiton
( medicine_id VARCHAR(10),diagnosis_id INTEGER, appointment_id INTEGER, med_dose SMALLINT)
BEGIN
INSERT INTO Prescription
VALUES (medicine_id,diagnosis_id , appointment_id, med_dose);
end//
DELIMITER ;

-- Inserting data in appointment table using procedure
DROP PROCEDURE IF EXISTS AppointmentInsert;
DELIMITER //
CREATE PROCEDURE AppointmentInsert
(patient_id Integer, registered_by_id integer, doc_id integer, start_time datetime, end_time datetime)
BEGIN
  INSERT INTO appointment(patient_id, registered_by_id, doc_id, start_time, end_time)
  VALUES (patient_id, registered_by_id, doc_id, start_time, end_time);
END//
DELIMITER ;
-- Can call the stored procedure to set the appointment using the below testing data 
-- CALL AppointmentInsert(18, 7, 9, '2021-11-15 01:30:00','2021-11-15 01:30:00');
-- select * from appointment ;

-- Inserting data into patient table
DROP PROCEDURE IF EXISTS PatientInsert;
DELIMITER //
CREATE PROCEDURE PatientInsert
(patient_id Integer, patient_fname VARCHAR(50), patient_lname VARCHAR(50), gender VARCHAR(1), address VARCHAR(100), phone VARCHAR(10), email_id VARCHAR(50), patient_dob date,Insurance_id INTEGER)
BEGIN
  INSERT INTO patient(patient_id, patient_fname, patient_lname, gender, address, phone, email_id, patient_dob, Insurance_id)
  VALUES (patient_id, patient_fname, patient_lname, gender, address, phone, email_id, patient_dob, Insurance_id);
END//
DELIMITER ;
-- CALL PatientInsert(18, 7, 9, '2021-11-15 01:30:00','2021-11-15 01:30:00'); -- change the values as per the table


-- Procedure for Retreiving a patient from the system 
DROP PROCEDURE IF EXISTS pid_match_testing;
DELIMITER //
CREATE PROCEDURE pid_match_testing (pid_para INT)
BEGIN
  IF exists (select * from patient p where p.patient_id = pid_para) 
  THEN
  select concat(p.patient_fname," ",p.patient_lname) as patient_name, p.patient_dob, p.phone, p.email_id
  from patient p
  where pid_para = p.patient_id;
  else
  SIGNAL SQLSTATE '45000'
      SET MYSQL_ERRNO = '1700',
          MESSAGE_TEXT = 'The given patient does not exists in the database';  
  END IF;
END//
DELIMITER ;

-- call pid_match_testing(12);-- success
-- call pid_match_testing(99);-- fail

############################################################################################################################################
-- Updating stored procedures
############################################################################################################################################
-- updating the data in appointment table using the procedure
DROP PROCEDURE IF EXISTS AppointmentUpdate;
DELIMITER //
CREATE PROCEDURE AppointmentUpdate
(a_appointment_id integer, a_patient_id Integer, a_registered_by_id integer, a_doc_id integer, a_start_time datetime, a_end_time datetime)
BEGIN
 update appointment
 set patient_id=a_patient_id , registered_by_id = a_registered_by_id, doc_id=a_doc_id, start_time=a_start_time, end_time = a_end_time
 where appointment_id = a_appointment_id;
END//
DELIMITER ;
-- Can call the stored procedure to update the appointment using the below testing data 
-- CALL AppointmentUpdate(1012,	18,	7,	9,	'2021-11-15 01:30:00',	'2021-11-15 02:00:00');
-- select * from appointment ;

-- Updating data in test_avail table using procedure
DROP PROCEDURE IF EXISTS TestAvailUpdate;
DELIMITER //
CREATE PROCEDURE TestAvailUpdate
(t_test_id Integer, t_name VARCHAR(100), t_description VARCHAR(200), t_price INTEGER)
BEGIN
  UPDATE test_Avail set name =t_name, description = t_description, price = t_price
  where test_id = t_test_id;
END//
DELIMITER ;

-- updating the patient table for address phone no. and insurance id using procedure
DROP PROCEDURE IF EXISTS patientUpdate;
DELIMITER //
CREATE PROCEDURE patientUpdate(p_patient_id integer, p_address varchar(100), p_phone varchar(10), p_insurance_id integer)	
BEGIN 
update patient
set  address=p_address, phone=p_phone, insurance_id = p_insurance_id
where patient_id= p_patient_id;
END //
DELIMITER ;
-- select * from patient where patient_id = '11';
-- updating the patient table for changing the address using below test data
-- call patientUpdate(11,'710 Edmonds Ave Drexel Hill 3000','7849900521','23778950');
-- select * from patient;

-- procedure for updating medication table
DROP PROCEDURE IF EXISTS update_medication;
DELIMITER //
CREATE PROCEDURE update_medication
(new_appointment_id INTEGER, new_medicine_id VARCHAR(10), new_med_dose SMALLINT)
BEGIN
update medication set 
medicine_id = new_medicine_id, med_dose =new_med_dose
where appointment_id = new_appointment_id;
end//
DELIMITER ;


-- stored procedure to find update the staff table
DROP PROCEDURE IF EXISTS StaffUpdate;
DELIMITER //
CREATE PROCEDURE StaffUpdate
(new_Staff_id Integer, new_personal_identification_number integer, new_first_name VARCHAR(50), new_last_name VARCHAR(50), new_email_id VARCHAR(50), new_designation VARCHAR(50), new_salary DECIMAL(9, 2 ))
BEGIN
  UPDATE staff set personal_identification_number = new_personal_identification_number ,first_name = new_first_name, last_name=new_last_name,email_id = new_email_id,  designation = new_designation, salary=new_salary 
  WHERE staff_id = new_staff_id;
END//
DELIMITER ;

-- updating the patient_symptoms table using procedure
DROP PROCEDURE IF EXISTS update_PatientSymptoms;
DELIMITER //
CREATE PROCEDURE update_PatientSymptoms(new_appointment_id INTEGER, new_coldSores TINYINT, new_acne TINYINT,
new_sunBurns TINYINT, new_hives TINYINT, new_rosacea TINYINT, new_psoriasis TINYINT, new_melanoma TINYINT, new_cosmeticRelated TINYINT, 
new_Dermatitis TINYINT)
BEGIN
UPDATE Patient_symptoms SET coldSores = new_coldSores, acne=new_acne,
sunBurns=new_sunBurns, hives=new_hives, rosacea=new_rosacea, 
psoriasis=new_psoriasis, melanoma=new_melanoma, cosmeticRelated=new_cosmeticRelated, 
Dermatitis=new_Dermatitis
WHERE appointment_id = new_appointment_id;
END//
DELIMITER;
############################################################################################################################################
-- Deleting stored procedures
#############################################################################################################################################
-- procedure for deleting patient info from patient table
DROP PROCEDURE IF EXISTS delete_patientInfo;
DELIMITER //
CREATE PROCEDURE delete_patientInfo
(new_patient_id integer)
BEGIN
	Delete from patient where patient_id= new_patient_id;
end//
DELIMITER ;

-- procedure for deleting staff information
DROP PROCEDURE IF EXISTS delete_StaffInformation;
DELIMITER //
CREATE PROCEDURE delete_StaffInformation
(new_staff_id integer)
BEGIN
	Delete from staff where staff_id = new_staff_id;
end//
DELIMITER ;

-- procedure for deleting appointment
DROP PROCEDURE IF EXISTS delete_Appointment;
DELIMITER //
CREATE PROCEDURE delete_Appointment
(new_appointment_id integer)
BEGIN
Delete from appointment where appointment_id = new_appointment_id;
end//
DELIMITER ; 

-- procedure for deleting test availability in the clinic
DROP PROCEDURE IF EXISTS delete_testAvail;
DELIMITER //
CREATE PROCEDURE delete_testAvail
(new_test_id integer)
BEGIN
Delete from test_avail where test_id = new_test_id;
end//
DELIMITER ; 

-- procedure for deleting medication
DROP PROCEDURE IF EXISTS delete_medciation;
DELIMITER //
CREATE PROCEDURE delete_medciation
(new_appointment_id INTEGER)
BEGIN
Delete from medication where appointment_id = new_appointment_id;
end//
DELIMITER ;

-- procedure for deleting a particular medicine avaialbility
DROP PROCEDURE IF EXISTS delete_medAvail;
DELIMITER //
CREATE PROCEDURE delete_medAvail
(new_medicine_id integer)
BEGIN
Delete from medicine_avail where medicine_id = new_medicine_id;
end//
DELIMITER ; 

####################################################################################################################
-- selecting the data using stored procedure
#####################################################################################################################
-- procedure for selecting payment info of patient
DROP PROCEDURE IF EXISTS paymentInfo;
DELIMITER //
CREATE PROCEDURE paymentInfo(payment_id_para varchar(50))
BEGIN
select a1.appointment_id,p2.patient_id,p1.payment_id,p1.payment_method,p1.payment_total,p1.payment_date from appointment a1 join payment p1 on a1.appointment_id=p1.appointment_id
join patient p2 on p2.patient_id=a1.patient_id
where payment_id = payment_id_para;
END//
DELIMITER ;

-- procedure for selecting patient symptoms
DROP PROCEDURE IF EXISTS patientSymptoms;
DELIMITER //
CREATE PROCEDURE patientSymptoms(patient_id_para integer)
BEGIN
select  concat(p1.patient_fname," ",p1.patient_lname)as 'patientName',s1.* from patient_symptoms s1 join appointment a1 on s1.appointment_id=a1.appointment_id
join patient p1 on p1.patient_id=a1.patient_id
where p1.patient_id = patient_id_para;
END //
DELIMITER ;

-- procedure for selecting patient name from patient table
DROP PROCEDURE IF EXISTS patientName;
DELIMITER //
CREATE PROCEDURE patientName(patient_id_para integer)
BEGIN 
select concat(p1.patient_fname," ",p2.patient_lname)
from patient p1, patient p2
where p1.patient_id=p2.patient_id and p1.patient_id = patient_id_para;
END //
DELIMITER ;




