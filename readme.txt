
This file contains the following:

data_ingest
//commands for data ingestion 

etl_code
//ETL Mapreduce code for two data sources: bike info and weather

profiling_code 
//Profiling code

code_iterations
//we don't use any iterations code, so this is empty

Mapreduce_classJarfiles
//Contains the class and jar files for the map reduce process:
//for Citibike data sources and weather data sources

FigureCode
//Contains python code for making figures and generate predicative models

screenshots
//screenshots for the analytics

Analytics
//Contains code for the analytics part

*****************
To run this project, run the etl_code and profiling_code first
With data input on Dumbo-hdfs. Input file location:
/user/zl2277/FinalProject/2018citiBikeData

Specific procedures as follows:

** bike Mapreduce
javac -classpath `yarn classpath` -d . bikeMapperInfo.java

javac -classpath `yarn classpath` -d . bikeReducerInfo.java

javac -classpath `yarn classpath`:. -d . bikeInfo.java

jar -cvf citibikeInfo.jar *.class

hadoop jar citibikeInfo.jar bikeInfo /user/zl2277/FinalProject/2018citiBikeData /user/zl2277/FinalProject/2018citiBikeData/output


** bikeInfo mapreduce

javac -classpath `yarn classpath` -d . bikeMapper.java
javac -classpath `yarn classpath` -d . bikeReducer.java
javac -classpath `yarn classpath`:. -d . bike.java

jar -cvf citiBike.jar *.class

hadoop jar citiBike.jar bike /user/zl2277/FinalProject/2018citiBikeData /user/zl2277/FinalProject/hourlyOut/

** weather map reduce.

javac -classpath `yarn classpath` -d . tempMapper.java

javac -classpath `yarn classpath` -d . tempReducer.java

javac -classpath `yarn classpath`:. -d . temp.java

jar -cvf tempNyc.jar *.class

hadoop jar tempNyc.jar temp /user/rs6565/FinalProject/nycWeather/2018nycWeather.csv /user/rs6565/FinalProject/nycWeather/output

**After above commands, follow the steps in analytics folder, AnalyticsCodeFinal.hql

Run each line of AnalyticsCodeFinal.hql

