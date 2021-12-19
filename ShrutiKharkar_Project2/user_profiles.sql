USE my_dermat_db;

Flush privileges;
select * from staff;

-- drop if already existing
drop user 'doctor_staff'@'localhost';
drop user 'admin_staff'@'localhost';
drop user 'receptionist_staff'@'localhost';
drop user 'nursing_staff'@'localhost';
drop user 'test&technical_staff'@'localhost';

-- creating new users
create user 'doctor_staff'@'localhost' identified by 'doctor_staff';
create user 'receptionist_staff'@'localhost' identified by 'receptionist_staff';
create user 'nursing_staff'@'localhost' identified by 'nursing_staff';
create user 'admin_staff'@'localhost' identified by 'admin_staff';
create user 'test&technical_staff'@'localhost' identified by 'test&technical_stafff';

-- Admin staff is provided all the grants for looking after the application is working smoothly or not
GRANT ALL PRIVILEGES ON *.* TO 'admin_staff'@'localhost' WITH GRANT OPTION;

-- receptionist staff grants
grant all privileges on my_dermat_db.patient to 'receptionist_staff'@'localhost';
grant all privileges on my_dermat_db.Appointment to 'receptionist_staff'@'localhost';
grant select on my_dermat_db.Patient_Symptoms to 'receptionist_staff'@'localhost';
grant select on my_dermat_db.staff to 'receptionist_staff'@'localhost';
grant update,select on my_dermat_db.payment to 'receptionist_staff'@'localhost';
grant select on my_dermat_db.Audit_Patient to 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.StaffUpdate TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.StaffInsert TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.paymentInfo TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.pid_match_testing TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.patientName TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.patientInsert TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.delete_StaffInformation TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.delete_patientInfo TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.delete_Appointment TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.AppointmentUpdate TO 'receptionist_staff'@'localhost';
GRANT execute ON PROCEDURE my_dermat_db.AppointmentInsert TO 'receptionist_staff'@'localhost';

-- Test and Technical staff grants
grant select on my_dermat_db.patient to 'test&technical_staff'@'localhost';
grant select on my_dermat_db.audit_patient to 'test&technical_staff'@'localhost';
grant select  on my_dermat_db.audit_Appointment to 'test&technical_staff'@'localhost';
grant all privileges on my_dermat_db.patient_results to 'test&technical_staff'@'localhost';
grant all privileges on my_dermat_db.patient_test to 'test&technical_staff'@'localhost';
grant all privileges on my_dermat_db.test_avail to 'test&technical_staff'@'localhost';
grant select on my_dermat_db.medication to 'test&technical_staff'@'localhost';
grant execute on procedure my_dermat_db.delete_testAvail TO 'test&technical_staff'@'localhost';
grant execute on procedure my_dermat_db.TestAvailInsert TO 'test&technical_staff'@'localhost';
grant execute on procedure my_dermat_db.TestAvailUpdate TO 'test&technical_staff'@'localhost';

-- Nursing staff grants
grant all privileges on my_dermat_db.Patient_Symptoms to 'nursing_staff'@'localhost'; 
grant select on my_dermat_db.patient to 'nursing_staff'@'localhost';
grant select on my_dermat_db.audit_patient to 'nursing_staff'@'localhost';
grant update, select on my_dermat_db.medication to 'nursing_staff'@'localhost';
grant select on my_dermat_db.audit_medication to 'nursing_staff'@'localhost';
grant select on my_dermat_db.Patient_test to 'nursing_staff'@'localhost';
grant select on my_dermat_db.medicine_Avail to 'nursing_staff'@'localhost';
grant select on my_dermat_db.audit_medicine_Avail to 'nursing_staff'@'localhost';
grant select on my_dermat_db.patient_diagnosis to 'nursing_staff'@'localhost';
grant execute on procedure my_dermat_db.update_PatientSymptoms TO 'nursing_staff'@'localhost';
grant execute on procedure my_dermat_db.patientSymptoms TO 'nursing_staff'@'localhost';
grant execute on procedure my_dermat_db.insert_medicaiton TO 'nursing_staff'@'localhost';
grant execute on procedure my_dermat_db.delete_medciation TO 'nursing_staff'@'localhost';
grant execute on procedure my_dermat_db.update_medication TO 'nursing_staff'@'localhost';

-- Specialist and Consultant doctors grants	
grant all privileges on my_dermat_db.Patient_test to 'doctor_staff'@'localhost';
grant select on my_dermat_db.patient to 'doctor_staff'@'localhost';
grant select on my_dermat_db.audit_patient to 'doctor_staff'@'localhost';
grant select on my_dermat_db.Patient_diagnosis to 'doctor_staff'@'localhost';
grant all privileges on my_dermat_db.medication to 'doctor_staff'@'localhost';
grant all privileges on my_dermat_db.audit_medication to 'doctor_staff'@'localhost';
grant select on my_dermat_db.Patient_results to 'doctor_staff'@'localhost';
grant execute on procedure my_dermat_db.update_PatientSymptoms TO 'doctor_staff'@'localhost';
grant execute on procedure my_dermat_db.patientSymptoms TO 'doctor_staff'@'localhost';
grant execute on procedure my_dermat_db.insert_medicaiton TO 'doctor_staff'@'localhost';
grant execute on procedure my_dermat_db.delete_medciation TO 'doctor_staff'@'localhost';
grant execute on procedure my_dermat_db.update_medication TO 'doctor_staff'@'localhost';
