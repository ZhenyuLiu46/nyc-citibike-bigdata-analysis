beeline

!connect jdbc:hive2://babar.es.its.nyu.edu:10000/

use zl2277;

show tables;

--//build citibike table
create external table citibike (TIME string, COUNT int) row format delimited fields terminated by '\t' location '/user/zl2277/FinalProject/hourlyOut/';

--//build weather table
create external table weatherComp (TIME string, Temp int, Precip int, Wind int) row format delimited fields terminated by '\t' location '/user/zl2277/FinalProject/Analytics/';

--//join citibike data and weather data
CREATE TABLE citibikeWeather AS SELECT b.TIME, b.COUNT, w.Temp, w.Precip, w.Wind FROM bike b JOIN weathercomp w ON (b.TIME = w.TIME);


--//analyze bike ride count group by month
create table citibikeMonthSum as Select SUBSTRING(time, 1, 7), sum(count) from citibikeWeather group by SUBSTRING(time, 1, 7);
create table citibikeMonthAvg as Select SUBSTRING(time, 1, 7), avg(count) from citibikeWeather group by SUBSTRING(time, 1, 7);


--//analyze bike ride count group by hour
create table citibikehourSum as Select SUBSTRING(time, 12, 13), sum(count) from citibikeWeather group by SUBSTRING(time, 12, 13);
create table citibikehourAvg as Select SUBSTRING(time, 12, 13), avg(count) from citibikeWeather group by SUBSTRING(time, 12, 13);


--//analyze hourly bike ride count (maximum, minimum, average)
select max(citibikeweather.count) from citibikeweather;
select min(citibikeweather.count) from citibikeweather;
select avg(citibikeweather.count) from citibikeweather;

--//analyze temperature (maximum, minimum, average)
select max(citibikeweather.temp) from citibikeweather;
select min(citibikeweather.temp) from citibikeweather;
select avg(citibikeweather.temp) from citibikeweather;

--//analyze precipitation (maximum, minimum, average)
select max(citibikeweather.precip) from citibikeweather;
select min(citibikeweather.precip) from citibikeweather;
select avg(citibikeweather.precip) from citibikeweather;

--//analyze wind speed (maximum, minimum, average)
select max(citibikeweather.wind) from citibikeweather;
select min(citibikeweather.wind) from citibikeweather;
select avg(citibikeweather.wind) from citibikeweather;

--//analyze linear correlation between weather condition and bike ride count
select corr(citibikeweather.count, citibikeweather.precip) from citibikeweather;
--//-0.04
select corr(citibikeweather.count, citibikeweather.temp) from citibikeweather;
--//0.38
select corr(citibikeweather.count, citibikeweather.wind) from citibikeweather;
--//-0.13


--//analyze linear correlation for peaktime rider count and weather
--//build peaktime table
create table peaktime as select * from citibikeweather where SUBSTRING(citibikeweather.time, 12, 13)='08' or SUBSTRING(citibikeweather.time, 12, 13)='09' or SUBSTRING(citibikeweather.time, 12, 13)='17' or SUBSTRING(citibikeweather.time, 12, 13)='18';

select corr(peaktime.count, peaktime.precip) from peaktime;
--//-0.10
select corr(peaktime.count, peaktime.temp) from peaktime;
--//0.60
select corr(peaktime.count, peaktime.wind) from peaktime;
--//-0.25


--//analyze linear correlation for valleytime rider count and weather
--//build valleytime table
create table valleytime as select * from citibikeweather where SUBSTRING(citibikeweather.time, 12, 13)<'07' or SUBSTRING(citibikeweather.time, 12, 13)>'20';

select corr(valleytime.count, valleytime.precip) from valleytime;
--//-0.05
select corr(valleytime.count, valleytime.temp) from valleytime;
--//0.39
select corr(valleytime.count, valleytime.wind) from valleytime;
--//-0.15


--//analyze linear correlation for othertime bike ride and weather
--//build other time table
create table othertime as select * from citibikeweather where SUBSTRING(citibikeweather.time, 12, 13)>'09' and SUBSTRING(citibikeweather.time, 12, 13)<'17' or SUBSTRING(citibikeweather.time, 12, 13)='20' or SUBSTRING(citibikeweather.time, 12, 13)='19' or SUBSTRING(citibikeweather.time, 12, 13)='07';

select corr(othertime.count, othertime.precip) from othertime;
--//-0.07
select corr(othertime.count, othertime.temp) from othertime;
--//0.65
select corr(othertime.count, othertime.wind) from othertime;
--//-0.30


--//analyze linear corrlation of precipitation and count in warm and cold months
--//build warm month table
create table warm as select * from citibikeweather where SUBSTRING(time, 6, 7) >'04' and SUBSTRING(time, 6, 7)<'11';
select corr(warm.count, warm.precip) from warm;
--//-0.04

--//build warm month valley time table
create table valleywarm as select * from warm where SUBSTRING(warm.time, 12, 13)<'07' or SUBSTRING(warm.time, 12, 13)>'20';
select corr(valleywarm.count, valleywarm.precip) from valleywarm;
--//-0.06

--//build warm month peak time table
create table peakwarm as select * from warm where SUBSTRING(warm.time, 12, 13)='08' or SUBSTRING(warm.time, 12, 13)='09' or SUBSTRING(warm.time, 12, 13)='17' or SUBSTRING(warm.time, 12, 13)='18';
select corr(peakwarm.count, peakwarm.precip) from peakwarm;
--//-0.13

--//build warm month other time table
create table otherwarm as select * from warm where SUBSTRING(warm.time, 12, 13)>'09' and SUBSTRING(warm.time, 12, 13)<'17' or SUBSTRING(warm.time, 12, 13)='20' or SUBSTRING(warm.time, 12, 13)='19' or SUBSTRING(warm.time, 12, 13)='07';
select corr(otherwarm.count, otherwarm.precip) from otherwarm;
--//-0.10


--//cold
--//build cold month table
create table cold as select * from citibikeweather where SUBSTRING(time, 6, 7) <'05' or SUBSTRING(time, 6, 7)>'10';
select corr(cold.count, cold.precip) from cold;
--//-0.11

--// build cold month valley time table
create table valleycold as select * from cold where SUBSTRING(cold.time, 12, 13)<'07' or SUBSTRING(cold.time, 12, 13)>'20';
select corr(valleycold.count, valleycold.precip) from valleycold;
--//-0.09

--//build cold month peak time table
create table peakcold as select * from cold where SUBSTRING(cold.time, 12, 13)='08' or SUBSTRING(cold.time, 12, 13)='09' or SUBSTRING(cold.time, 12, 13)='17' or SUBSTRING(cold.time, 12, 13)='18';
select corr(peakcold.count, peakcold.precip) from peakcold;
--//-0.19

--//build cold month other time table
create table othercold as select * from cold where SUBSTRING(cold.time, 12, 13)>'09' and SUBSTRING(cold.time, 12, 13)<'17' or SUBSTRING(cold.time, 12, 13)='20' or SUBSTRING(cold.time, 12, 13)='19' or SUBSTRING(cold.time, 12, 13)='07';
select corr(othercold.count, othercold.precip) from othercold;
--//-0.17


--//analyze count group by month
create table citibikeMonthSum as Select SUBSTRING(time, 1, 7), sum(count) from citibikeWeather group by SUBSTRING(time, 1, 7);
create table citibikeMonthAvg as Select SUBSTRING(time, 1, 7), avg(count) from citibikeWeather group by SUBSTRING(time, 1, 7);

--//analyze weather group by month
create table weatherMonthAvg as Select SUBSTRING(time, 1, 7), avg(temp, precip, wind) from weathercomp group by SUBSTRING(time, 1, 7);



--//analysis bike data information
create external table bikeInfo (startTime string, tripDuration int, startStationID int, startStationName string, startStationlatitude double, startStationlongitude double, endStationID int, endStationName string, endStationLatitude double, endStationLongtitude double, userType string, birthYear int, gender int) row format delimited fields terminated by '\t' location '/user/zl2277/FinalProject/2018citiBikeData/output/';

CREATE TABLE tripDurationWeather AS SELECT SUBSTRING(b.starttime,1,13), b.tripduration, w.Temp, w.Precip, w.Wind FROM bikeinfo b JOIN weathercomp w ON (SUBSTRING(b.starttime, 1,13) = w.TIME);

select corr(tripdurationweather.tripduration, tripdurationweather.precip) from tripdurationweather;
// -4.7439496896396755E-4


--// Analyze customer and subscriber total rentership in a year
select count(*) from bikeinfo where bikeinfo.usertype = '"Customer"';
// 1905117
select count(*) from bikeinfo where bikeinfo.usertype = '"Subscriber"';
// 15593585 


--// Analyze gender rentership in a year
select count(*) from bikeinfo where bikeinfo.gender = 1;
--//11847580  male
select count(*) from bikeinfo where bikeinfo.gender = 2;
--//4069799 female
select count(*) from bikeinfo where bikeinfo.gender = 0;
//1581323 unkown


--// Analyze age
select avg(bikeinfo.birthyear) from bikeinfo;
--//1978.8976608006685 
select min(bikeinfo.birthyear) from bikeinfo;
--//1884
select max(bikeinfo.birthyear) from bikeinfo;
--//2002

--// age <=20
select count(*) from bikeinfo where bikeinfo.birthyear >= 1998;
--//233759

--// age 20-30
select count(*) from bikeinfo where bikeinfo.birthyear < 1998 and bikeinfo.birthyear >=1988;
--// 4808173 

--// age 30-40
select count(*) from bikeinfo where bikeinfo.birthyear < 1988 and bikeinfo.birthyear >=1978;
--// 5075384 

--// age 40-50
select count(*) from bikeinfo where bikeinfo.birthyear < 1978 and bikeinfo.birthyear >=1968;
--// 4183421 

--// age 50-60
select count(*) from bikeinfo where bikeinfo.birthyear < 1968 and bikeinfo.birthyear >=1958;
--// 2060491

--// age > 60
select count(*) from bikeinfo where bikeinfo.birthyear < 1958;
--// 814820 


--// Analyze station
--// analyze by station id
SELECT startStationID,COUNT(*) AS c FROM bikeinfo GROUP BY startStationID ORDER BY c DESC;
--// analyze by station name
SELECT startStationName,COUNT(*) AS c FROM bikeinfo GROUP BY startStationName ORDER BY c DESC;


--// Analyze station
--// analyze by station name
SELECT endStationName,COUNT(*) AS c FROM bikeinfo GROUP BY endStationName ORDER BY c DESC;







