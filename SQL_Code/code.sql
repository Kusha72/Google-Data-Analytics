

---Case Study 1: How Does a Bike-Share Navigate Speedy Success?


 CREATE TABLE `capstone-362223.Capstone_Project.Annual_Cycling` AS

  (SELECT *
  FROM `capstone-362223.Capstone_Project.July_2022` AS July_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.June_2022` AS June_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.May_2022` AS May_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.April_2022` AS April_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.March_2022` AS March_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.February_2022` AS February_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.January_2022` AS January_2022
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.December_2021` AS December_2021
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.November_2021` AS November_2021
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.October_2021` AS October_2021
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.September_2021` AS September_2021
  UNION ALL

  SELECT *
  FROM `capstone-362223.Capstone_Project.August_2021` AS August_2021
  );

---------------------------------------------------------------------------

SELECT COUNT (1) AS total_rows
FROM `capstone-362223.Capstone_Project.Annual_Cycling`

------------------------------------------------------------

alter VIEW `capstone-362223.Capstone_Project.View_Cycling` to
SELECT *, (ended_at - started_at) AS ride_length
FROM `capstone-362223.Capstone_Project.Annual_Cycling`


drop view `capstone-362223.Capstone_Project.View_Cycling`

create view `capstone-362223.Capstone_Project.View_Cycling` as 
SELECT *, TIMESTAMP_DIFF(ended_at, started_at, minute) AS ride_length, extract(dayofweek from ended_at) as day_of_week
FROM `capstone-362223.Capstone_Project.Annual_Cycling`



Select min (end_lng), max(end_lng), min (end_lat), max(end_lat), min (start_lng), max(start_lng), min (start_lat), max(start_lat)
from `capstone-362223.Capstone_Project.View_Cycling`



select end_station_id, end_station_name, count(1)
from `capstone-362223.Capstone_Project.View_Cycling`
group by end_station_id, end_station_name



select rideable_type, count(1)
from `capstone-362223.Capstone_Project.View_Cycling`
group by rideable_type

select ride_id, count(1)
from `capstone-362223.Capstone_Project.View_Cycling`
group by ride_id
having count(1)>1

select *
from `capstone-362223.Capstone_Project.View_Cycling`
where started_at IS NULL and ended_at IS NULL

select *
from `capstone-362223.Capstone_Project.View_Cycling`
where started_at IS NULL OR ended_at IS NULL

/* Identify and Exclude Data With Anomolies */

/* Exclude cases where start time is greater than end time */


create table capstone-362223.Capstone_Project.Final_Cycling as 
SELECT *
FROM capstone-362223.Capstone_Project.View_Cycling
WHERE (case when started_at >= ended_at then 1
      when ride_length IS NULL OR ride_length <= 0 then 1
      when start_station_name IS NULL OR end_station_name IS NULL then 1
      else 0 end) <> 1

