EMR Database System

Submitted to University of North Carolina at Charlotte
ITIS 6120 Applied Databases
10th December 2021
A database for an Electronic Medical Record System based on Dermatology clinic
By SHRUTI SHRIKANT KHARKAR

Deployment of Database scripts
1. Run the my_dermat_db.sql script file for creating the database tables.
2. Run Triggers.sql file which contains triggers.
3. Run Stored_procedures.sql file which contains queries for stored procedures.
4. Run my_dermat_db_insertion.sql which contains sample data which can be inserted into tables.
5. Run user_profiles.sql to create the users and share it among the staff based on their position.
6. my_dermat_db_testScripts.sql file is used to check the supporting funtionality of the database


There is just minor change in the medication and medicine_avail table with respect to foriegn keys:
where I have added one more foriegn key constraint in medication table and removed a foriegn key constraint from medicine_avail table.
The structure remains the same.
Also,in medication and medicine_avail table, the varchar length for column Medicine_id is changed to 10.
In patient_diagnosis table, varchar length of column Treatment is changed from 50 to 250 in project 2.
