create database procurement_spend_analysis;

use  procurement_spend_analysis;

Select * from procurement_ka;

-- 1. average unit price of all orders
select avg(unit_price) from procurement_ka;

-- 2. average negotiated price of all orders
select avg(negotiated_price) from procurement_ka;

-- 3. total quantity ordered across all orders
select sum(quantity) from procurement_ka;

-- 4. number of distinct suppliers
select count(distinct supplier) from procurement_ka;

-- 5. number of orders per item category
select item_category, count(*) from procurement_ka group by item_category;

-- 6. total defective units per item category
select item_category, sum(defective_units) from procurement_ka group by item_category;

-- 7. average defective units for 'delivered' orders
select avg(defective_units) from procurement_ka where order_status = 'delivered';

-- 8. total quantity of 'cancelled' orders
select sum(quantity) from procurement_ka where order_status = 'cancelled';

-- 9. number of orders with null delivery date
select count(*) from procurement_ka where delivery_date is null;

-- 10. average unit price for 'raw materials'
select avg(unit_price) from procurement_ka where item_category = 'raw materials';

-- 11. count of 'compliant' orders
select count(*) from procurement_ka where compliance = 'yes';

-- 12. maximum quantity ordered in a single po
select max(quantity) from procurement_ka;

-- 13. minimum quantity ordered in a single po
select min(quantity) from procurement_ka;

-- 14. total quantity of orders per supplier
select supplier, sum(quantity) from procurement_ka group by supplier;

-- 15. average unit price for supplier 'alpha_inc'
select avg(unit_price) from procurement_ka where supplier = 'alpha_inc';

-- 16. count of orders with zero defective units
select count(*) from procurement_ka where defective_units = 0;

-- 17. average negotiated price for 'electronics'
select avg(negotiated_price) from procurement_ka where item_category = 'electronics';

-- 18. total defective units for 'mro' category
select sum(defective_units) from procurement_ka where item_category = 'mro';

-- 19. number of orders per order status
select order_status, count(*) from procurement_ka group by order_status;

-- 20. average quantity for 'office supplies'
select avg(quantity) from procurement_ka where item_category = 'office supplies';

-- 21. average defective units for non-compliant orders
select avg(defective_units) from procurement_ka where compliance = 'no';

-- 22. count of po ids starting with 'po-00'
select count(*) from procurement_ka where po_id like 'po-00%';

-- 23. maximum unit price across all items
select max(unit_price) from procurement_ka;

-- 24. minimum unit price across all items
select min(unit_price) from procurement_ka;

-- 25. total quantity ordered in 2023
select sum(quantity) from procurement_ka where order_date between '2023-01-01' and '2023-12-31';

-- 26. number of orders with delivery date same as order date
select count(*) from procurement_ka where delivery_date = order_date;

-- 27. average savings per unit (unit_price - negotiated_price) for all orders
select avg(unit_price - negotiated_price) from procurement_ka;

-- 28. sum of defective units per supplier
select supplier, sum(defective_units) from procurement_ka group by supplier;

-- 29. count of orders where order status is 'pending'
select count(*) from procurement_ka where order_status = 'pending';

-- 30. average defective units per order for 'packaging' category
select avg(defective_units) from procurement_ka where item_category = 'packaging';



-- 31. average delivery delay (delivery_date - order_date) for 'delivered' orders
select avg(datediff(delivery_date, order_date)) from procurement_ka where order_status = 'delivered';

-- 32. total savings (quantity * (unit_price - negotiated_price)) per supplier
select supplier, sum(quantity * (unit_price - negotiated_price)) as total_savings 
from procurement_ka group by supplier order by total_savings desc;

-- 33. defect rate (sum(defective_units) / sum(quantity)) per item category
select item_category, (sum(defective_units) / sum(quantity)) * 100 as defect_rate_percent 
from procurement_ka group by item_category;

-- 34. top 5 suppliers by total quantity delivered
select supplier, sum(quantity) as total_quantity 
from procurement_ka where order_status = 'delivered' group by supplier order by total_quantity desc limit 5;

-- 35. monthly count of orders placed in 2023
select date_format(order_date, '%y-%m') as month, count(*) as order_count 
from procurement_ka where order_date between '2023-01-01' and '2023-12-31' group by month;

-- 36. total defective units per compliance status
select compliance, sum(defective_units) from procurement_ka group by compliance;

-- 37. suppliers with total defective units greater than 1000
select supplier, sum(defective_units) as total_defective from procurement_ka group by supplier having total_defective > 1000;

-- 38. average negotiated price per order status
select order_status, avg(negotiated_price) from procurement_ka group by order_status;

-- 39. count of non-compliant orders per supplier
select supplier, count(*) as non_compliant_count from procurement_ka where compliance = 'no' group by supplier;

-- 40. average quantity and average unit price per item category
select item_category, avg(quantity), avg(unit_price) from procurement_ka group by item_category;


-- 41. suppliers with avg delivery delay > overall avg for 'delivered' orders
select supplier, avg(datediff(delivery_date, order_date)) as avg_delay 
from procurement_ka where order_status = 'delivered' group by supplier having avg_delay > (select avg(datediff(delivery_date, order_date)) 
from procurement_ka where order_status = 'delivered');

-- 42. top 5 item categories by total cost (quantity * negotiated_price)
select item_category, sum(quantity * negotiated_price) as total_cost 
from procurement_ka group by item_category order by total_cost desc limit 5;

-- 43. monthly average defective rate (defective_units/quantity) for 2023
select date_format(order_date, '%y-%m') as month, avg(defective_units / quantity) * 100 as avg_defective_rate 
from procurement_ka where order_date between '2023-01-01' and '2023-12-31' group by month;

-- 44. suppliers with total cost savings > 5000 and defect rate < 0.05
select supplier, sum(quantity * (unit_price - negotiated_price)) as total_savings, (sum(defective_units) / sum(quantity)) as defect_rate 
from procurement_ka group by supplier having total_savings > 5000 and defect_rate < 0.05;

-- 45. orders where delivery_date is null but order_status is 'delivered'
select count(*) from procurement_ka where delivery_date is null and order_status = 'delivered';

-- 46. average negotiated price per supplier, only for orders with quantity > 1000
select supplier, avg(negotiated_price) from procurement_ka where quantity > 1000 group by supplier;

-- 47. total quantity of orders per month for 2022 and 2023
select date_format(order_date, '%y-%m') as month, sum(quantity) as total_quantity 
from procurement_ka where order_date between '2022-01-01' and '2023-12-31' group by month;

-- 48. top 3 item categories with highest average negotiated price
select item_category, avg(negotiated_price) as avg_price 
from procurement_ka group by item_category order by avg_price desc limit 3;

-- 49. rank suppliers by total defective units
select supplier, sum(defective_units) as total_defective, rank() over (order by sum(defective_units) desc) as defect_rank 
from procurement_ka group by supplier;

-- 50. cumulative quantity ordered by date in 2023
select order_date, sum(quantity) over (order by order_date) as cumulative_quantity 
from procurement_ka where order_date between '2023-01-01' and '2023-12-31';

-- 51. suppliers with both delivered and cancelled orders, and their total cancelled quantity
select supplier, sum(case when order_status = 'cancelled' then quantity else 0 end) as cancelled_quantity 
from procurement_ka group by supplier having cancelled_quantity > 0;

-- 52. find the correlation between quantity and defective_units (if applicable)
select (sum((quantity - avg_q) * (defective_units - avg_d)) / (sqrt(sum(pow(quantity - avg_q, 2))) * sqrt(sum(pow(defective_units - avg_d, 2))))) as correlation 
from (select quantity, defective_units, (select avg(quantity) from procurement_ka) as avg_q, (select avg(defective_units) 
from procurement_ka) as avg_d from procurement_ka) t;

-- 53. monthly total cost for each supplier in 2023
select supplier, date_format(order_date, '%y-%m') as month, sum(quantity * negotiated_price) as total_cost 
from procurement_ka where order_date between '2023-01-01' and '2023-12-31' group by supplier, month;
