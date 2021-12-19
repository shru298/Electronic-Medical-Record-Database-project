-- Insertion queries for inserting data in the above mentioned tables:

-- Inserting data into staff table
insert into Staff values 
(	1,	12351,	'Shruti',	'Kharkar',	'skhakar@gmail.com',	'Specialist Doctor',	11200	),
(	2,	12352,	'Rupa',	'Prajapati',	'rprajapati@gmail.com',	'Specialist Doctor',	11300	),
(	3,	12353,	'Shina',	'Dhingra',	'sdhingra@gmail.com',	'Nurse',	'8000'	),
(	4,	12354,	'Aishu',	'Babu',	'ababu@gmail.com',	'Test specialist',	9500	),
(	5,	12355,	'Hoshank',	'Mali',	'hmali@gmail.com',	'Consutling Doctor',	13000	),
(	6,	12356,	'Guarav',	'Mulay',	'gmulay@gmail.com',	'Consutling Doctor',	14000	),
(	7,	12357,	'Sakshi',	'Gadhari',	'sgadhari@gmail.com',	'Medical Receptionist',	5500	),
(	8,	12358,	'Ankita',	'Chavan',	'achavan@gmail.com',	'Medical Receptionist',	6500	),
(	9,	12359,	'Koshik',	'Kool',	'kkool@gmail.com',	'Specialist Doctor',	12000	);

-- Inserting data into insurance table
insert into insurance values('23778950', 'ISO', 'ISO Bronze plan'), 
('23778951','ISO', 'ISO Silver plan'),
('23778952', 'ISO', 'ISO Gold plan'),
('23778953', 'CVS', 'CVS health insurance plan'),
('23778954','Anthem','Anthem Healthcare'),
('23778955','Humana','Humana insurance plan for health');

-- Inserting data into patient table
insert into patient values (	11,	'Jim ',	'Halpert',	'M',	'709 Edmonds Ave Drexel Hill 19026',	7849900321,	'jhalpert@gmail.com',	'1997-01-01',	'23778950'),
(12,	'Michael ',	'Scott',	'M',	'513 Encino Dr Aptos 5003',	7849900322,	'mscott@gmail.com',	'1991-02-02'	,'23778952'),
(13,'Dwight',	'Schrute',	'M',	'1001 K Graduate lane 28262',	7849900323,	'dschrute@gmail.com',	'1992-03-05',	'23778951'),
(14,	'Pam',	'Besley',	'F',	'9000 Z University city blvd 28621',	7849900324,'pbesley@gmail.com',	'1994-03-15',	'23778952'),
(15,	'Erin ',	'Hannon',	'F',	'429 Horseshoe lane 77839',	7849900325,	'ehannon@gmail.com',	'1989-04-11',	'23778955'),
(16,	'Angela',	'Martin',	'F',	'15885 W 157th St Olathe 66062',	7849900326,	'amartin@gmail.com',	'1989-07-19',	'23778955'),
(17, 'Jan',	'Levinson',	'F',	'Po Box 314 Wood Dale 60191',	7849900327	,'jlevinson@gmail.com',	'1987-09-12','23778950'),
(18,	'Kevin',	'Malone',	'M',	'601 Graisbury Ave Haddonfield 08033',	7849900328,	'kmalone@gmail.com',	'1985-12-02',	'23778954'),
(19,	'Creed',	'Bratton',	'M',	'513 Encino Dr Aptos 95003',	7849900329,	'cbratton@gmail.com','1987-08-29','23778955'),
(20,	'Kelly',	'Kapoor',	'F',	'8516 Allenswood Rd Randallstown 21133',	7849900330,	'kkapoor@gmail.com','1996-06-14',	'23778952'),
(22,	'Adam',	'Sandler',	'M',	'9201 California illinois',	8888899008,	'asandler@gmail.com','1998-03-11',	'23778954');


-- Inserting data into Appointment table
Insert into appointment values (	'1000',	'11','8',	'1',	'2021-10-26 9:30:00',	'2021-10-26 9:55:00'),
('1001',	'12',	'7',	'2',	'2021-10-26 10:00:00',	'2021-10-26 10:30:00'),
('1002',	'13',	'8',	'1',	'2021-10-26 10:45:00',	'2021-10-26 10:11:00'),
('1003',	'14',	'7',	'5',	'2021-10-27 11:00:00',	'2021-10-27 11:30:00'),
('1004',	'15',	'8',	'6',	'2021-10-27 11:15:00',	'2021-10-27 12:00:00'),
('1005',	'16',	'8',	'6',	'2021-10-27 12:15:00',	'2021-10-27 12:45:00'),
('1006',	'17',	'8',	'5',	'2021-10-28 01:00:00',	'2021-10-28 01:15:00'),
('1007',	'18',	'7',	'9',	'2021-10-28 01:30:00',	'2021-10-28 02:10:00'),
('1008',	'19',	'7',	'1',	'2021-10-28 02:25:00',	'2021-10-28 03:00:00'),
('1013',	'22',	'8',	'5',	'2021-11-12 01:00:00',	'2021-11-12 01:30:00');

-- Inserting data into patient_symptoms table
Insert into patient_symptoms values(1000,1,1,0,0,	0,0,0,0,0),
(1001,0,0,1,1,1,0,0,0,0),
(1002,0,1,0,0,1,1,1,0,0),
(1003,0,0,0,1,0,0,1,1,0),
(1004,1,1,1,0,0,0,0,0,1),
(1005,0,0,0,0,0,0,0,0,0),
(1006,0,0,0,1,1,1,0,0,1),
(1007,1,0,0,1,1,0,1,1,0),
(1008,0,0,0,0,0,1,0,1,1);
 
 -- Inserting data into patient_diagnosis table

 insert into  patient_diagnosis values
(99991,11,'Prescribed antibiotic for Skin:erythromycin'),
(99992,12,'Prescribed antibiotic tetracycline'),
(99993,13,'Prescribed dicloxacillin for skin issues'),
(99994,14,'Suggested to take up laser therapy with additional supplements'),
(99995,15,'Prescibed medicated creams and ointments'),
(99996,16,'Prescribes to take antihistamines for issues'),
(99997,17,'Prescirbed Adapalene gel'),
(99998,18,'Suggest to take up plastic surgery with vitamins and other supplements'),
(99999,19,'Suggest to take vitamin or steroid injections');

-- Inserting data into medication table
insert into medication values(100,99991, 1000, 1),
(200,99992, 1001, 2),
(300,99993, 1002, 3),
(400,99994, 1003, 1),
(500, 99995, 1004, 3),
(600, 99996, 1005, 4),
(700, 99997, 1006, 2),
(800, 99998, 1007, 3),
(900, 99999, 1008, 5),
(900, 99998, 1013, 3);

-- Inserting data into Medicine_avail table
insert into Medicine_avail values(100,'erythromycin', 'Glaxo smith Kline: erythromycin', '99.2'),
(200,'tetracycline','CVS tetracycline', '100.67' ),
(300, 'dicloxacillin', 'Publix dicloxacillin', '889.9'),
(400, 'Corticosteriod','Hindal','2889'),
(500, 'B12','Publix B12','445.10'),
(600, 'glucosamine','Hindal Glucose','77.99'),
(700, 'cyanocobalamin', 'walmart cyano', '667'),
(800, 'niacinamide','Glaxo kline nia', '33.99'),
(900, 'itraconazole', 'Walmart center', '55.9');

-- Inserting data into test_avail table
insert into test_avail values (100001,'Patch Testing', 'patch tests are used to diagnose skin allergies','12345'),
(100002, 'Skin biopsy', 'Used to diagnose skin cancer or benign skin disorders','23356'),
(100003,'Culture','identification of the microorganism (bacteria, fungus, or virus) that is causing an infection','8867'),
(100004,'Dermoscopy','Used to better see the lesions on the skin','8947'),
(100005,'Plastic Surgery','Used to refine the look of the body or face','98490');

-- inserting data into Patient_test table
insert into Patient_test values(123,1000, 100000, '2021-10-26 10:00:00', 1),
(234, 1001, 100001, '2021-10-26 11:00:00', 2),
(345, 1002, 100002, '2021-10-26 12:00:00', 1),
(456, 1003, 100003, '2021-10-27 09:00:00', 5),
(567, 1004, 100004, '2021-10-27 10:00:00', 6),
(678, 1005, 100005, '2021-10-27 11:00:00', 6),
(789, 1006, 100002, '2021-10-28 01:00:00', 5),
(890, 1007, 100003, '2021-10-28 02:00:00', 9),
(901, 1008, 100004, '2021-10-28 02:00:00', 1);

-- Inserting data into patient_results
insert into patient_results values(123, 'Very serious condition'),
(234,'mild condition identified'),
(345,'no serious conditiond found'),
(456,'mild condition identified'),
(567,'serious condition found'),
(678, 'no issues found'),
(789,'mild to serious condition found'),
(890, 'insignificant issues found'),
(901, 'acute issues identified');