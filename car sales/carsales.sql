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

