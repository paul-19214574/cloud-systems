REGISTER 'CustomMappings.py' using jython as custom_mappings

INPUT_V1 = LOAD '/prepared-data/v1' 
           USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') 
           AS (Province_State:chararray, Country_Region:chararray, Last_Update:chararray, Confirmed:int, Deaths:int, Recovered:int);
INPUT_V2 = LOAD '/prepared-data/v2'
           USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') 
           AS (Province_State:chararray, Country_Region:chararray, Last_Update:chararray, Confirmed:int, Deaths:int, Recovered:int);
INPUT_V3 = LOAD '/prepared-data/v3'
           USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') 
           AS (Province_State:chararray, Country_Region:chararray, Last_Update:chararray, Confirmed:int, Deaths:int, Recovered:int);
INPUT_V4 = LOAD '/prepared-data/v4' 
           USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') 
           AS (Province_State:chararray, Country_Region:chararray, Last_Update:chararray, Confirmed:int, Deaths:int, Recovered:int);
INPUT_V5 = LOAD '/prepared-data/v5'
           USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') 
           AS (FIPS:chararray, Admin2:chararray, Province_State:chararray, Country_Region:chararray, Last_Update:chararray, Lat:chararray, Long_:chararray, Confirmed:int, Deaths:int, Recovered:int);
INPUT_V6 = LOAD '/prepared-data/v6'
           USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') 
		   AS (FIPS:chararray, Admin2:chararray, Province_State:chararray, Country_Region:chararray, Last_Update:chararray, Lat:chararray, Long_:chararray, Confirmed:int, Deaths:int, Recovered:int);

OUTPUT_V1 = FOREACH INPUT_V1 GENERATE 
              Province_State, custom_mappings.mapcountry(Country_Region), custom_mappings.mapdate1(Last_Update), 
              (Confirmed IS NOT NULL ? Confirmed : 0) AS Confirmed, 
              (Deaths IS NOT NULL ? Deaths : 0) AS Deaths,
              (Recovered IS NOT NULL ? Recovered : 0) AS Recovered;
OUTPUT_V2 = FOREACH INPUT_V2 GENERATE 
              Province_State, custom_mappings.mapcountry(Country_Region), custom_mappings.mapdate2(Last_Update),
              (Confirmed IS NOT NULL ? Confirmed : 0) AS Confirmed, 
              (Deaths IS NOT NULL ? Deaths : 0) AS Deaths,
              (Recovered IS NOT NULL ? Recovered : 0) AS Recovered;
OUTPUT_V3 = FOREACH INPUT_V3 GENERATE
              Province_State, custom_mappings.mapcountry(Country_Region), custom_mappings.mapdate3(Last_Update),
              (Confirmed IS NOT NULL ? Confirmed : 0) AS Confirmed, 
              (Deaths IS NOT NULL ? Deaths : 0) AS Deaths,
              (Recovered IS NOT NULL ? Recovered : 0) AS Recovered;
OUTPUT_V4 = FOREACH INPUT_V4 GENERATE
              Province_State, custom_mappings.mapcountry(Country_Region), custom_mappings.mapdate3(Last_Update),
              (Confirmed IS NOT NULL ? Confirmed : 0) AS Confirmed, 
              (Deaths IS NOT NULL ? Deaths : 0) AS Deaths,
              (Recovered IS NOT NULL ? Recovered : 0) AS Recovered;
OUTPUT_V5 = FOREACH INPUT_V5 GENERATE
              Province_State, custom_mappings.mapcountry(Country_Region), custom_mappings.mapdate2(Last_Update),
              (Confirmed IS NOT NULL ? Confirmed : 0) AS Confirmed, 
              (Deaths IS NOT NULL ? Deaths : 0) AS Deaths,
              (Recovered IS NOT NULL ? Recovered : 0) AS Recovered;
OUTPUT_V6 = FOREACH INPUT_V6 GENERATE
              Province_State, custom_mappings.mapcountry(Country_Region), custom_mappings.mapdate4(Last_Update),
              (Confirmed IS NOT NULL ? Confirmed : 0) AS Confirmed, 
              (Deaths IS NOT NULL ? Deaths : 0) AS Deaths,
              (Recovered IS NOT NULL ? Recovered : 0) AS Recovered;

OUTPUT_ALL = UNION OUTPUT_V1,OUTPUT_V2,OUTPUT_V3,OUTPUT_V4,OUTPUT_V5,OUTPUT_V6;

STORE OUTPUT_ALL into '/staged-data/' 
      USING org.apache.pig.piggybank.storage.CSVExcelStorage('|','NO_MULTILINE','NOCHANGE','SKIP_OUTPUT_HEADER');




