USE classicmodels;

/*1. Do a backup of a classicmodels database using mysqldump. 
Do a backup without data (only tables structure).*/
mysqldump --user=mroot --password=12345678 --result-file=/home/alumati/copia_estructura_classicmodels.sql --no-data --databases classicmodels

/*2. Import the backup of the exercise 1 to classicmodels_copia 
database. Check if backup is well done.*/
mysql> use classicmodels_copia;
mysql> show tables;
mysql> source /home/alumati/copia_estructura_classicmodels.sql;


/*3. Do a backup of a classicmodels database using mysqldump. 
Backup file has to include data.*/
mysqldump --user=mroot --password=12345678 --result-file=/home/alumati/copia_estructura_classicmodels_data.sql --databases classicmodels

/*4. Import the backup of the exercise 3 to classicmodels_copia 
database. Check if backup is well done.*/


/*5. Try to do a backup using workbench or phpmyadmin.*/


/*6. Import backup file to the exercise5.*/


/*7. Export the data to the customer table (fields: 
customerName, contactLastName, contactFirstName, phone) into 
customers.csv file . Note that state can be null so you have 
to solve this problem.*/


/*8. Load the data of the csv file (exercise 7) into table temp.*/


/*9. Do the exercises of XML/JSON/MYSQL.*/
