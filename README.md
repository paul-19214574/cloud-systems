# cloud-systems

## Demo

  A working version of the application is available here.
  
  https://public.tableau.com/profile/paul.doherty#!/vizhome/Covid19DataWorkbook/Covid19

## Files

| File                                   | Purpose                                                                          |
| -------------------------------------- | -------------------------------------------------------------------------------- |
| CloudSystemAssignment1Architecture.jpg | Output of HQL script to select the first 10 rows in the HIVE table               |
| Covid19DataHiveSelect10Row.jpg         | Output of HQL script to select the first 10 rows in the HIVE table               |
| Covid19DataWorkbook.pptx               | Powerpoint file containing the Covid charts which are visible in Tableau Public  |
| Covid19DataWorkbook.twbx               | Tableau Desktop workbook file containing Covid-19 workbook files                 |
| CreateAndPopulateHiveTable.hql         | HQL script to create the HIVE table and to populate it with Covid-19 data        |
| CustomMappings.py                      | Pig UDF Python file containing custom mapping code (for countries and dates)     |
| DownloadCovid19Data.py                 | Downloads the Covid-19 data files from github                                    |
| FormatCovid19Data.pig                  | Pig script use to format and transform the Covid-19 data files                   |
| PrepareCovid19Data.py                  | Prepare the Covid-19 data files depending on their formats (v1 - v6)             |
| README.md                              | This README file containing describing the assignment and steps taken            |


## Steps

1. Download the Covid-19 data files for the specified date range

   `python DownloadCovid19Data.py dd-mm-yyyy dd-mm-yyyy`
   e.g. `python DownloadCovid19Data.py 01-22-2020 04-05-2020`

2. Prepare the Covid-19 data files into different directories depending on the format of the files
 
   `python PrepareCovid19Data.py dd-mm-yyyy dd-mm-yyyy`
   e.g. `python PrepareCovid19Data.py 01-22-2020 04-05-2020`
  
3. Copy the prepared data from the local directory to HDFS

   `hadoop fs -mkdir /prepared-data`
   
   `hadoop fs -put ../prepared-data/* /prepared-data`
   
4. Format the Covid-19 data using Pig
 
   `pig FormatCovid19Data.pig`

5. Connect to Hive using Beeline Hive Client and Create the table to store the Covid-19 data, and then load the data.
 
   `beeline -u jdbc:hive2://localhost:10000/default`
   
   `!run CreateAndPopulateHiveTable.hql`
   
   and then to verify that the table has been created and processed correctly:
   
   `SELECT * FROM covid_19_data LIMIT 10`

6. Migrate the data from HDFS to Google Cloud Storage
  
   `beeline --showHeader=false --outputformat=dsv --delimiterForDSV=, -u jdbc:hive2://localhost:10000/default -e "SELECT * FROM covid_19_data;" > final-data.txt`
   
   and then copy the final data to GFS
   
   `gsutil cp final-data.txt gs://cloud-systems-assignment-1/final-data.txt`
   
 7. Load data from Google Cloud Storage into BigQuery
 
    See instructions available here (https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-csv)
    
 8. Using Tableau Desktop connect to Google BigQuery and load dataset into Tableau. Configure worksheets, build dashboard and deploy to Tablea Public
   
