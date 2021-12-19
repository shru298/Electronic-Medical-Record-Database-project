-- Dermatology clinic based Electronic Medical Record System database
	
-- Database creation
DROP DATABASE IF EXISTS my_dermat_db;
CREATE DATABASE my_dermat_db;

use my_dermat_db;
-- To clear the SQL mode explicitly, set it to an empty string
SET SESSION sql_mode = '';
set foreign_key_checks=0;

-- Table creation queries:

-- Staff Table
CREATE TABLE Staff (
    Staff_id INTEGER NOT NULL PRIMARY KEY,
    personal_identification_number INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_id VARCHAR(50) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    salary DECIMAL(9, 2 ) NOT NULL
);

-- Insurance Table
CREATE TABLE Insurance(
    Insurance_id INTEGER NOT NULL PRIMARY KEY,
    In_provider VARCHAR(255) NOT NULL,
    In_plan_name VARCHAR(255) NOT NULL
);

-- Patient Table
CREATE TABLE Patient (
    patient_id INTEGER NOT NULL,
    patient_fname VARCHAR(50) NOT NULL,
    patient_lname VARCHAR(50) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    email_id VARCHAR(50) NOT NULL,
    patient_dob DATE NOT NULL,
	Insurance_id INTEGER NOT NULL,
    PRIMARY KEY (patient_id),
	CONSTRAINT fk_insurance_patient FOREIGN KEY (insurance_id)
        REFERENCES Insurance (Insurance_id)
);

-- Appointment table 
CREATE TABLE Appointment (
     appointment_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
     patient_id INTEGER NOT NULL,
     registered_by_id INTEGER NOT NULL,
     doc_id INTEGER NOT NULL,
     start_time DATETIME NOT NULL,
     end_time DATETIME NOT NULL,
     CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id)
        REFERENCES Patient (patient_id),
     CONSTRAINT fk_appointment_doc FOREIGN KEY (doc_id)
        REFERENCES Staff (Staff_id),
     CONSTRAINT fk_appointment_register FOREIGN KEY (registered_by_id)
        REFERENCES Staff (Staff_id)
);

-- Payment table
CREATE TABLE Payment (
    payment_id INTEGER UNIQUE AUTO_INCREMENT,
    appointment_id INTEGER NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_total DECIMAL(9,2),
    CONSTRAINT fk_appointment_payment FOREIGN KEY (appointment_id)
        REFERENCES Appointment (appointment_id)
);
  
-- Patient Symptoms table
CREATE TABLE Patient_symptoms (
    appointment_id INTEGER NOT NULL UNIQUE,
    coldSores TINYINT NOT NULL,
    acne TINYINT NOT NULL,
    sunBurns TINYINT NOT NULL,
    hives TINYINT NOT NULL,
    rosacea TINYINT NOT NULL,
    psoriasis TINYINT NOT NULL,
    melanoma TINYINT NOT NULL,
    cosmeticRelated TINYINT NOT NULL,
    Dermatitis TINYINT NOT NULL,
    CONSTRAINT fk_appointment_symptoms FOREIGN KEY (appointment_id)
        REFERENCES Appointment (appointment_id)
);

-- Patient diagnosis table
CREATE TABLE Patient_diagnosis (
    diagnosis_id INTEGER NOT NULL PRIMARY KEY,
    patient_id INTEGER NOT NULL,
    Treatment VARCHAR(250) NOT NULL,
    CONSTRAINT fk_patient FOREIGN KEY (patient_id)
        REFERENCES Patient (patient_id)
);

-- Medication table -- added new foreign key
CREATE TABLE Medication ( 
	medicine_id VARCHAR(10) NOT NULL,
    diagnosis_id integer not null,
    appointment_id INTEGER NOT NULL,
    med_dose SMALLINT NOT NULL,
	PRIMARY KEY(appointment_id, medicine_id),
    CONSTRAINT fk_patient_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointment (appointment_id),
	CONSTRAINT fk_prescrip_medicine FOREIGN KEY (medicine_id)
        REFERENCES Medicine_avail (medicine_id)
);

-- Medicine availability table ---- remove the foreign key
CREATE TABLE Medicine_avail (
    medicine_id VARCHAR(10) NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    price DECIMAL(9,2)
);

-- Test/procedure availibility table
CREATE TABLE test_avail (
    test_id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(200) NOT NULL,
    price INTEGER NOT NULL
);
-- Patient test table

CREATE TABLE Patient_test (
	procedure_id INTEGER NOT NULL UNIQUE,
    appointment_id INTEGER NOT NULL,
    procedure_code INTEGER NOT NULL,
    performed_on DATETIME NOT NULL,
    doc_id INTEGER NOT NULL,
    PRIMARY KEY (appointment_id, procedure_code),
	CONSTRAINT fk_test_avail FOREIGN KEY (procedure_code)
        REFERENCES test_avail (test_id),
    CONSTRAINT fk_appointment FOREIGN KEY (appointment_id)
        REFERENCES Appointment (appointment_id),
    CONSTRAINT fk_doc_id FOREIGN KEY (doc_id)
        REFERENCES Staff (Staff_id)
);

-- Patient Results table
CREATE TABLE patient_results (
     procedure_id INTEGER NOT NULL,
	 test_result VARCHAR(100) NOT NULL,
	 CONSTRAINT fk_procedure_results FOREIGN KEY (procedure_id)
        REFERENCES Patient_test (procedure_id)
);

-- Audit table creation:

CREATE TABLE audit_appointment(patient_id int not null,
                           start_time datetime not null,
                           end_time datetime not null,
                           action_type varchar(50) not null,
						   action_date datetime not null);

CREATE TABLE audit_patient (
    patient_id	INTEGER NOT NULL,
    patient_fname VARCHAR(50) NOT NULL,
    patient_lname VARCHAR(50) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    email_id VARCHAR(50) NOT NULL,
    patient_dob DATE NOT NULL,
    Insurance_id INTEGER NOT NULL,
	Action_Performed Varchar(50) NOT NULL,
    Action_Time DATETIME NOT NULL
);

CREATE TABLE audit_staff (
    Staff_id INTEGER NOT NULL,
    personal_identification_number INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_id VARCHAR(50) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    salary DECIMAL(9, 2 ) NOT NULL,
	Action_Performed Varchar(50) NOT NULL,
    Action_Time DATETIME NOT NULL
);


CREATE TABLE audit_medicine_avail (
    medicine_id VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    price DECIMAL(9,2),
    Action_Performed Varchar(50) NOT NULL,
    Action_Time DATETIME NOT NULL
);

CREATE TABLE audit_medication ( 
	medicine_id VARCHAR(10) NOT NULL,
    diagnosis_id integer not null,
    appointment_id INTEGER NOT NULL,
    med_dose SMALLINT NOT NULL,
	Action_Performed Varchar(50) NOT NULL,
    Action_Time DATETIME NOT NULL
);


-- Indexes Creation

-- Index to identify patient on patient first name
CREATE INDEX patient_information ON patient(patient_id DESC);
-- Index to identify patient on patient insurance ID
CREATE INDEX patient_insurance_info ON patient(insurance_id DESC);
-- Index to identify physician based on name
CREATE INDEX Doctor_info ON staff(first_name DESC);
-- Index to identify physician based on designtion
CREATE INDEX Doctor_designation_info ON staff(designation DESC);
-- Index to identify physician based on unique identification number
CREATE INDEX Doctor_PIN_info ON staff(Personal_Identification_number DESC);
-- Index to get Medicine availability based on name
CREATE INDEX medicine_avail_info ON medicine_avail(name DESC);
-- Index to get Test availability information based on name
CREATE INDEX test_avail_info ON test_avail(name DESC);
-- Index to get payment details based on payment Id	
CREATE INDEX patient_payment_info ON Payment(payment_id DESC);

-- Views creation

-- View for appointment timing information
Create view appointmentTimeInfo as select appointment_id, patient_id,doc_id, start_time, end_time
from appointment;
-- select * from appointmentTimeInfo; --- testing purposes

-- View for staff basic information
Create view staffBasicInfo as select Staff_id, Personal_identification_number, first_name, last_name, email_id from staff;
-- select * from staffBasicInfo; -- testing purposes

-- View for patient contact information
Create view patientContactInfo as select patient_id, patient_fname, patient_lname, address, phone, email_id from patient;
-- select * from patientContactInfo; -- testing purposes

-- View for payment sum till date information 
Create view paymentSumInfo as select sum(payment_total) as 'Total sum of amounts till date' from payment;
-- select * from paymentSumInfo; -- testing purposes

-- View for data of the patient who have been given certain diagnosis and medicine for particular dianosis
Create view patientDiagnosisInfo as select  d1.diagnosis_id, d1.patient_id, concat(p1.patient_fname," ",p1.patient_lname) as patient_name,
d1.treatment as Diagnosis, m1.medicine_id
from patient_diagnosis d1 join patient p1 join medication m1
where d1.patient_id = p1.patient_id
and d1.diagnosis_id = m1.diagnosis_id;
-- select * from patientDiagnosisInfo;-- testing purposes








