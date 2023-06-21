LOAD DATA LOCAL INFILE 'D:\\Processes\\Tangelo\\data\\credit_record.csv' INTO TABLE tbl_credit_record
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES; 

LOAD DATA LOCAL INFILE 'D:\\Processes\\Tangelo\\data\\application_record.csv' INTO TABLE tbl_application_record
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES; 
###################################

CREATE TABLE dim_status(
	  id_status integer NOT NULL AUTO_INCREMENT
    , cod_status char(1)
    , desc_status varchar(100)
    , load_date timestamp
    , PRIMARY KEY(id_status)
) ;


#######################################

CREATE TABLE fact_transactions(
	  id_transaction integer NOT NULL
    , id_client integer
    , id_status integer
    , id_month integer
    , load_date timestamp
    , updated_at timestamp
    , PRIMARY KEY (id_transaction)
);

#select * from fact_transactions;

################################

drop table dim_clients;
CREATE TABLE dim_clients(
	  id_client integer
	, cohort integer
	, gender varchar(10)
    , ind_own_car boolean
    , ind_own_realty boolean
    , cnt_children integer
    , amt_income_total double(17,2)
    , name_income_type varchar(50)
    , name_education_type varchar(50)
    , name_family_status varchar(50)
    , name_housing_type varchar(50)
    , birth_date date
    , employed_date date
    , ind_mobil boolean
    , ind_work_phone boolean
    , ind_phone boolean
    , ind_email boolean
    , desc_occupation_type varchar(50)
    , cnt_fam_members integer
    , load_date timestamp
    , updated_at timestamp
    , primary key(id_client)
);

select * from dim_clients;


##################################

#select * from dim_status
#excecute dim_status ETL

UPDATE dim_status
SET desc_status = '1-29 days past due'
WHERE cod_status = '0';
UPDATE dim_status
SET desc_status = '30-59 days past due'
WHERE cod_status = '1';
UPDATE dim_status
SET desc_status = '60-89 days overdue'
WHERE cod_status = '2';
UPDATE dim_status
SET desc_status = '90-119 days overdue'
WHERE cod_status = '3';
UPDATE dim_status
SET desc_status = '120-149 days overdue'
WHERE cod_status = '4';
UPDATE dim_status
SET desc_status = 'Overdue or bad debts, write-offs for more than 150 days'
WHERE cod_status = '5';
UPDATE dim_status
SET desc_status = 'paid off that month'
WHERE cod_status = 'C';
UPDATE dim_status
SET desc_status = 'No loan for the month'
WHERE cod_status = 'X';


