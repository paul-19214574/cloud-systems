# cloud-systems

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
   
   and then to verify that the table has been created and poplulated correctly:
   
   `SELECT * FROM covid_19_data LIMIT 10`
