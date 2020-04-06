CREATE TABLE covid_19_data (
  region STRING,
  country STRING,
  timing STRING,
  confirmed INT,
  deaths INT,
  recovered INT
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|';

LOAD DATA INPATH '/staged-data' INTO TABLE covid_19_data
