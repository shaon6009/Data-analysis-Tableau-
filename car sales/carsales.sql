use carsales2;
-- besic info --
select * from carsales;

select count(car_id) from carsales;

select distinct(company) from carsales;

select sum(price)/1000000 as total_revenaue_in_Million from carsales;

select gender, avg(cast(annual_income as bigint)) from carsales group by Gender;

select top 10 Company,Body_Style, max(price) as highest_price from carsales group by company, Body_Style order by highest_price desc ;

select body_style, count(*) from carsales group by Body_Style;

select top 10 Dealer_Region, Dealer_Name , sum(price) from carsales group by Dealer_Region, Dealer_Name;

select count(distinct model) from carsales;

select transmission, count(*) from carsales group by transmission order by count(*) desc;

select * from carsales where cast(annual_income as bigint) > (select avg(cast(annual_income as bigint)) from carsales);

-- COMPLEX QUESTIONS --
--Rank cars by price within each company
select company, model, price, dense_rank() over(partition by  company order by price desc) as rank from carsales;
select company, model, price, row_number() over(partition by  company order by price desc) as rank from carsales;

-- Running total sales per region--
select dealer_region, date, sum(price) over(partition by dealer_region order by date) as running_total from carsales;

--Top earning customer per region --
select * from( select *, row_number() over(partition by dealer_region order by price desc) rrank from carsales) t where rrank=1;

-- Lag function (previous sale price)--
select model, price, lag(price) over(order by date) as prev_price from carsales;

--Difference from previous sale--
select model, price, price- lag(price) over(order by date) as difference from carsales;

--Create partitioned table by region--
--create table car_sales_part using delta partition by(dealer_region) as select * from carsales;-- thsi will work with databricks and pyspark--
-- SELECT * FROM car_sales_part WHERE Dealer_Region = 'Aurora'; --

--Pre-aggregation (before join)--
WITH agg AS (
  SELECT Dealer_Region, SUM(Price) total FROM carsales GROUP BY Dealer_Region)SELECT * FROM agg;

 --Post-aggregation--
 select dealer_region, count(*) from(select * from carsales)t group by Dealer_Region;

 --Mask income--
 SELECT 
CASE WHEN [Annual_Income] > 50000 THEN 'HIGH'
  ELSE 'LOW'
END AS income_group FROM carsales;

-- Top 3 regions by revenue --
select top 10 dealer_region,Dealer_Name, sum(price) as total from carsales group by Dealer_Region, Dealer_Name order by total desc;

-- Top 3 regions by revenue --
select top 3 Dealer_Region, sum(price) total from carsales group by Dealer_Region order by total desc;

--Percent contribution per region--
select dealer_region, round(sum(cast(price as bigint)) * 100.0 / SUM(SUM(CAST(Price AS FLOAT))) OVER(), 2) AS Percentage
from carsales group by dealer_region;

-- Moving average price --
select date, avg(price) over(order by date rows between 2 preceding and current row) as moving_avg 
from carsales;
