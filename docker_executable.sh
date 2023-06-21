#!/bin/bash

# Define variables
DATABASE_IMAGE="mysql:latest"
CONTAINER_NAME="mysql"
DATABASE_NAME="mydatabase"

# Create Docker container
echo "Creating Docker container..."

#Create Docker container
docker run -d -p 5555:3306 --name "$CONTAINER_NAME" -e MYSQL_DATABASE="$DATABASE_NAME"  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_ROOT_HOST='%' "$DATABASE_IMAGE" 
echo "Docker container created successfully!"
echo "mydatabase has been created!"

# Wait for the container to start
sleep 10

service mysql start

# Import CSV files into the MySQL database
docker cp "data/credit_record.csv" "$CONTAINER_NAME:/var/lib/mysql-files/credit_record.csv"
docker cp "data/application_record.csv" "$CONTAINER_NAME:/var/lib/mysql-files/application_record.csv"

#Credit Record
docker exec -it "$CONTAINER_NAME" sh -c "mysql -uroot $DATABASE_NAME -h 127.0.0.1 -P 3306 -e 'CREATE TABLE credit_record (ID INT, MONTHS_BALANCE INT, STATUS VARCHAR(5));'"
docker exec -it "$CONTAINER_NAME" sh -c "mysql -uroot $DATABASE_NAME -h 127.0.0.1 -P 3306 -e 'LOAD DATA INFILE \"/var/lib/mysql-files/credit_record.csv\" INTO TABLE credit_record FIELDS TERMINATED BY \",\" LINES TERMINATED BY \"\n\" IGNORE 1 ROWS;'"
echo "Table credit_record has been created and loaded!"

#Application Record
docker exec -it $CONTAINER_NAME sh -c "mysql -uroot $DATABASE_NAME -h 127.0.0.1 -P 3306 -e 'CREATE TABLE application_record 
(ID INT,
CODE_GENDER VARCHAR(5),
FLAG_OWN_CAR VARCHAR(5),
FLAG_OWN_REALTY VARCHAR(5),
CNT_CHILDREN INT,
AMT_INCOME_TOTAL FLOAT,
NAME_INCOME_TYPE VARCHAR(30),
NAME_EDUCATION_TYPE VARCHAR(30),
NAME_FAMILY_STATUS VARCHAR(30),
NAME_HOUSING_TYPE VARCHAR(30),
DAYS_BIRTH INT,
DAYS_EMPLOYED INT,
FLAG_MOBIL VARCHAR(30),
FLAG_WORK_PHONE INT,
FLAG_PHONE INT,
FLAG_EMAIL INT,
OCCUPATION_TYPE VARCHAR(30),
CNT_FAM_MEMBERS INT);'"
docker exec -it $CONTAINER_NAME sh -c "mysql -uroot $DATABASE_NAME -h 127.0.0.1 -P 3306 -e 'LOAD DATA INFILE \"/var/lib/mysql-files/application_record.csv\" INTO TABLE application_record FIELDS TERMINATED BY \",\" LINES TERMINATED BY \"\n\" IGNORE 1 ROWS;'"
echo "Table application_record has been created and loaded!"
