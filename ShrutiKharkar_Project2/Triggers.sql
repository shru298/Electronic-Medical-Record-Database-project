-- Creating a trigger for maintaining an audit record for keeping the Record/track of appointment changes history of a patient. Can be used further for reoprting. 

                           
DROP TRIGGER IF EXISTS after_UpdateAppointment;
DELIMITER //
CREATE TRIGGER after_UpdateAppointment
  AFTER UPDATE ON appointment
  FOR EACH ROW
BEGIN
    INSERT INTO audit_appointment VALUES
    (OLD.patient_id, OLD.start_time, OLD.end_time,'UPDATED', NOW());
END//
DELIMITER ;
-- testing using the below update statement
update appointment
set end_time  = '2021-11-12 01:45:00'
where appointment_id= '1010';

Select * from audit_appointment;-- checking if the row is inserted in the audit table

-- Creating a trigger for maintaining an audit record for keeping the Record/track of appointment changes history of a patient. Can be used further for reoprting. 
DROP TRIGGER IF EXISTS after_InsertAppointment;
DELIMITER //
CREATE TRIGGER after_InsertAppointment
  AFTER INSERT ON appointment
  FOR EACH ROW
BEGIN
    INSERT INTO audit_appointment VALUES
    (NEW.patient_id, NEW.start_time, NEW.end_time,'INSERT', NOW());
END//
DELIMITER ;

-- Creating a trigger for maintaining an audit record for keeping the Record/track of appointment changes history of a patient. Can be used further for reoprting. 
DROP TRIGGER IF EXISTS after_DeleteAppointment;
DELIMITER //
CREATE TRIGGER after_DeleteAppointment
  AFTER DELETE ON appointment
  FOR EACH ROW
BEGIN
    INSERT INTO audit_appointment VALUES
    (OLD.patient_id, OLD.start_time, OLD.end_time,'DELETE', NOW());
END//
DELIMITER ;

-- Creating a trigger for maintaining an audit record for the record/track of patient informations changes

DROP TRIGGER IF EXISTS after_InsertPatientInfo;
DELIMITER //
CREATE TRIGGER after_InsertPatientInfo
  AFTER INSERT on patient
  FOR EACH ROW
BEGIN
  INSERT INTO audit_patient VALUES 
  (NEW.patient_id, NEW.patient_fname, NEW.patient_lname, NEW.gender, NEW.address, NEW.phone, NEW.email_id, NEW.patient_dob, NEW.Insurance_id,'INSERT', now());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS after_UpdatePatientInfo;
DELIMITER //
CREATE TRIGGER after_UpdatePatientInfo
  AFTER UPDATE on patient
  FOR EACH ROW
BEGIN
  INSERT INTO audit_patient VALUES 
  (OLD.patient_id, OLD.patient_fname, OLD.patient_lname, OLD.gender, OLD.address, OLD.phone, OLD.email_id, OLD.patient_dob, OLD.Insurance_id,'UPDATE', now());
END//
DELIMITER ;


DROP TRIGGER IF EXISTS after_DeletePatientInfo;
DELIMITER //
CREATE TRIGGER after_DeletePatientInfo
  AFTER DELETE on patient
  FOR EACH ROW
BEGIN
  INSERT INTO audit_patient VALUES 
  (OLD.patient_id, OLD.patient_fname, OLD.patient_lname, OLD.gender, OLD.address, OLD.phone, OLD.email_id, OLD.patient_dob, OLD.Insurance_id,'DELETE', now());
END//
DELIMITER ;

-- Creating a trigger for maintaining an audit record for the record/track of patient informations changes


DROP TRIGGER IF EXISTS after_InsertStaffInfo;
DELIMITER //
CREATE TRIGGER after_InsertStaffInfo
  AFTER INSERT ON staff
  FOR EACH ROW
BEGIN
  INSERT INTO audit_staff
  VALUES (NEW.Staff_id, NEW.personal_identification_number,NEW.first_name, NEW.last_name, NEW.email_id,NEW.designation, NEW.salary,
 'INSERT', now());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS after_UpdateStaffInfo;
DELIMITER //
CREATE TRIGGER after_UpdateStaffInfo
  AFTER UPDATE ON staff
  FOR EACH ROW
BEGIN
  INSERT INTO audit_staff
  VALUES (OLD.Staff_id, OLD.personal_identification_number,OLD.first_name, OLD.last_name, OLD.email_id,OLD.designation, OLD.salary,
 'UPADTE', now());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS after_DeleteStaffInfo;
DELIMITER //
CREATE TRIGGER after_DeleteStaffInfo
  AFTER DELETE ON staff
  FOR EACH ROW
BEGIN
  INSERT INTO audit_staff
  VALUES (OLD.Staff_id, OLD.personal_identification_number,OLD.first_name, OLD.last_name, OLD.email_id,OLD.designation, OLD.salary,
 'DELETE', now());
END//
DELIMITER ;

-- Creating a trigger for maintaining an audit record for the record/track of Medicine availibility informations changes


DROP TRIGGER IF EXISTS after_insertMedicineAvail;
DELIMITER //
CREATE TRIGGER after_insertMedicineAvail
  AFTER INSERT ON medicine_avail
  FOR EACH ROW
BEGIN
  INSERT INTO audit_medicine_avail
  VALUES (NEW.medicine_id, NEW.name, NEW.brand, NEW.price,'INSERT', now());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS after_updateMedicineAvail;
DELIMITER //
CREATE TRIGGER after_updateMedicineAvail
  AFTER UPDATE ON medicine_avail
  FOR EACH ROW
BEGIN
  INSERT INTO audit_medicine_avail
  VALUES (OLD.medicine_id, OLD.name, OLD.brand, OLD.price,'UPDATE', now());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS after_deleteMedicineAvail;
DELIMITER //
CREATE TRIGGER after_deleteMedicineAvail
  AFTER DELETE ON medicine_avail
  FOR EACH ROW
BEGIN
  INSERT INTO audit_medicine_avail
  VALUES (OLD.medicine_id, OLD.name, OLD.brand, OLD.price,'DELETE', now());
END//
DELIMITER ;


-- Creating a trigger for maintaining an audit record for the record/track of Medication availibility informations changes
DROP TRIGGER IF EXISTS after_insertMedication;
DELIMITER //
CREATE TRIGGER after_insertMedication
  AFTER INSERT ON medication 
  FOR EACH ROW
BEGIN
  INSERT INTO audit_medication
  VALUES (NEW.medicine_id, NEW.diagnosis_id, NEW.appointment_id, NEW.med_dose,'INSERT', now());
END//
DELIMITER ;


DROP TRIGGER IF EXISTS after_updateMedication;
DELIMITER //
CREATE TRIGGER after_updateMedication
  AFTER UPDATE ON medication 
  FOR EACH ROW
BEGIN
  INSERT INTO audit_medication
  VALUES (OLD.medicine_id, OLD.diagnosis_id, OLD.appointment_id, OLD.med_dose,'UPDATE', now());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS after_deleteMedication;
DELIMITER //
CREATE TRIGGER after_deleteMedication
  AFTER DELETE ON medication 
  FOR EACH ROW
BEGIN
  INSERT INTO audit_medication
  VALUES (OLD.medicine_id, OLD.diagnosis_id, OLD.appointment_id, OLD.med_dose,'DELETE', now());
END//
DELIMITER ;


-- Insert into payment table with the help of trigger on medication table and patient_test table
DROP TRIGGER IF EXISTS InsertPaymentTable_medication;
DELIMITER //

CREATE TRIGGER InsertPaymentTable_medication
  AFTER INSERT ON medication FOR EACH ROW
BEGIN
DECLARE total_med_cost DECIMAL(9,2);
DECLARE total_test_cost DECIMAL(9,2);
DECLARE total_cost DECIMAL(9,2);
DECLARE new_payment_id INTEGER;
  
SELECT SUM(med_cost) INTO total_med_cost FROM 
(SELECT (p.med_dose * d.price) as med_cost from medication p, medicine_avail d 
where  p.medicine_id = d.medicine_id and p.appointment_id = NEW.appointment_id) as t;

SELECT SUM(test_cost) INTO total_test_cost FROM 
(SELECT t.price as test_cost from patient_test p, test_avail t 
where  p.procedure_code = t.test_id and p.appointment_id = NEW.appointment_id) as q;

IF total_test_cost > 0 THEN
SET total_cost = total_med_cost + total_test_cost;
ELSE
SET total_cost = total_med_cost;
END IF;

SELECT MAX(payment_id) INTO @old_payment_id FROM payment;
SET new_payment_id = @old_payment_id + 1;

IF NEW.appointment_id not in 
(select appointment_id From payment where appointment_id = new.appointment_id) 
THEN
INSERT INTO payment values(new_payment_id, NEW.appointment_id,'System generated',  NOW(), total_cost);
ELSE
UPDATE payment SET payment_total = total_cost, payment_date = NOW() where appointment_id = NEW.appointment_id;
END IF;
END//
DELIMITER ;

-- update data into payment with the help of medication table trigger;
DELIMITER //

CREATE TRIGGER UpdatePaymentTable_medication
  AFTER UPDATE ON medication FOR EACH ROW
BEGIN
DECLARE total_med_cost  DECIMAL(9,2);
DECLARE total_test_cost  DECIMAL(9,2);
DECLARE total_cost  DECIMAL(9,2);
DECLARE new_payment_id  INTEGER;
  
SELECT SUM(med_cost) INTO total_med_cost  FROM 
(SELECT (p.med_dose * d.price) as med_cost from medication p, medicine_avail d 
where  p.medicine_id  = d.medicine_id and p.appointment_id = NEW.appointment_id) as t;

SELECT SUM(test_cost) INTO total_test_cost FROM 
(SELECT t.price as test_cost from patient_test p, test_avail  t 
where  p.procedure_code = t.test_id and p.appointment_id = NEW.appointment_id) as q;

IF total_test_cost  > 0 THEN
SET total_cost  = total_med_cost  + total_test_cost;
ELSE
SET total_cost  = total_med_cost;
END IF;

SELECT MAX(payment_id) INTO @old_payment_id  FROM payment;
SET new_payment_id  = @old_payment_id + 1;

IF NEW.appointment_id not in 
(select appointment_id From payment  where appointment_id = new.appointment_id) 
THEN
INSERT INTO payment  values(new_payment_id, NEW.appointment_id,'System generated',  NOW(), total_cost);
ELSE
UPDATE payment SET payment_total  = total_cost, payment_date  = NOW() where appointment_id = NEW.appointment_id;
END IF;

END//
DELIMITER ;

-- insert data into payment with the help of patient_test table
DROP TRIGGER IF EXISTS InsertPaymentTable_test;
DELIMITER //

CREATE TRIGGER InsertPaymentTable_test
  AFTER INSERT ON patient_test FOR EACH ROW
BEGIN
DECLARE total_med_cost DECIMAL(9,2);
DECLARE total_test_cost DECIMAL(9,2);
DECLARE total_cost DECIMAL(9,2);
DECLARE new_payment_id INTEGER;
  
SELECT SUM(med_cost) INTO total_med_cost FROM 
(SELECT (p.med_dose * d.price) as med_cost from medication p, medicine_avail d 
where  p.medicine_id = d.medicine_id and p.appointment_id = NEW.appointment_id) as t;

SELECT SUM(test_cost) INTO total_test_cost FROM 
(SELECT t.price as test_cost from patient_test p, test_avail t 
where  p.procedure_code = t.test_id and p.appointment_id = NEW.appointment_id) as q;

IF total_med_cost > 0 THEN
SET total_cost = total_med_cost + total_test_cost;
ELSE
SET total_cost = total_med_cost;
END IF;

SELECT MAX(payment_id) INTO @old_payment_id FROM payment;
SET new_payment_id = @old_payment_id + 1;

IF NEW.appointment_id not in 
(select appointment_id From payment where appointment_id = new.appointment_id) 
THEN
INSERT INTO payment values(new_payment_id, NEW.appointment_id,'System generated',  NOW(), total_cost);
ELSE
UPDATE payment SET payment_total = total_cost, payment_date = NOW() where appointment_id = NEW.appointment_id;
END IF;
END//
DELIMITER ;

-- uate data in payment table using the 

DROP TRIGGER IF EXISTS UpdatePaymentTable_test;
DELIMITER //

CREATE TRIGGER UpdatePaymentTable_test
  AFTER UPDATE ON patient_test FOR EACH ROW
BEGIN
DECLARE total_med_cost DECIMAL(9,2);
DECLARE total_test_cost DECIMAL(9,2);
DECLARE total_cost DECIMAL(9,2);
DECLARE new_payment_id INTEGER;
  
SELECT SUM(med_cost) INTO total_med_cost FROM 
(SELECT (p.med_dose * d.price) as med_cost from medication p, medicine_avail d 
where  p.medicine_id = d.medicine_id and p.appointment_id = NEW.appointment_id) as t;

SELECT SUM(test_cost) INTO total_test_cost FROM 
(SELECT t.price as test_cost from patient_test p, test_avail t 
where  p.procedure_code = t.test_id and p.appointment_id = NEW.appointment_id) as q;

IF total_med_cost > 0 THEN
SET total_cost = total_med_cost + total_test_cost;
ELSE
SET total_cost = total_med_cost;
END IF;

SELECT MAX(payment_id) INTO @old_payment_id FROM payment;
SET new_payment_id = @old_payment_id + 1;

IF NEW.appointment_id not in 
(select appointment_id From payment where appointment_id = new.appointment_id) 
THEN
INSERT INTO payment values(new_payment_id, NEW.appointment_id,'System generated',  NOW(), total_cost);
ELSE
UPDATE payment SET payment_total = total_cost, payment_date = NOW() where appointment_id = NEW.appointment_id;
END IF;
END//
DELIMITER ;

