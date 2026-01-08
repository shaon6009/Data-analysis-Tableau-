-- Use the database
CREATE DATABASE insurance_data;
USE insurance_data;

-- Assume your table is named 'insurance'

-- Q1. Total premium collected by gender
SELECT 
    gender,
    SUM(premium_amount) AS total_premium
FROM insurance
GROUP BY gender;

-- Q2. Insurers with total value created higher than overall average
SELECT 
    insurer_name,
    SUM(value_created) AS total_value_created
FROM insurance
GROUP BY insurer_name
HAVING SUM(value_created) > (
    SELECT AVG(total_value) 
    FROM (
        SELECT SUM(value_created) AS total_value
        FROM insurance
        GROUP BY insurer_name
    ) AS sub
);

-- Q3. Top 5 insurers with highest total value created
SELECT 
    insurer_name,
    SUM(value_created) AS total_value_created
FROM insurance
GROUP BY insurer_name
ORDER BY total_value_created DESC
LIMIT 5;

-- Q4. Total premium collected by each city
SELECT
    city,
    SUM(premium_amount) AS total_premium
FROM insurance
GROUP BY city
ORDER BY total_premium DESC;

-- Q5. Stakeholders with total AUM greater than average
SELECT
    stakeholder_name,
    SUM(assets_under_management) AS total_aum
FROM insurance
GROUP BY stakeholder_name
HAVING SUM(assets_under_management) > (
    SELECT AVG(total_aum) 
    FROM (
        SELECT SUM(assets_under_management) AS total_aum
        FROM insurance
        GROUP BY stakeholder_name
    ) AS sub
);

-- Q6. Average profitability by policy tenure
SELECT
    policy_tenure,
    ROUND(AVG(profitability), 2) AS avg_profitability
FROM insurance
GROUP BY policy_tenure
ORDER BY policy_tenure;

-- Q7. Asset type generating highest total value
SELECT
    asset_type,
    SUM(value_created) AS total_value_created
FROM insurance
GROUP BY asset_type
ORDER BY total_value_created DESC;

-- Q8. Relationship between cost ratio and profitability
SELECT
    cost_ratio,
    ROUND(AVG(profitability), 2) AS avg_profitability
FROM insurance
GROUP BY cost_ratio
ORDER BY cost_ratio;

-- Q9. Cities with profitability higher than overall average
SELECT
    city,
    SUM(profitability) AS total_profitability
FROM insurance
GROUP BY city
HAVING SUM(profitability) > (
    SELECT AVG(total_profit) 
    FROM (
        SELECT SUM(profitability) AS total_profit
        FROM insurance
        GROUP BY city
    ) AS sub
);

-- Q10. Monthly premium collection trend
SELECT
    DATE_FORMAT(policy_start_date, '%Y-%m') AS month,
    SUM(premium_amount) AS total_premium
FROM insurance
GROUP BY DATE_FORMAT(policy_start_date, '%Y-%m')
ORDER BY month;

-- Q11. Policies with Equity assets above average value created
SELECT
    policy_id,
    value_created
FROM insurance
WHERE asset_type = 'Equity'
AND value_created > (
    SELECT AVG(value_created)
    FROM insurance
);

-- Q12. Stakeholders contributing highest profitability
SELECT
    stakeholder_name,
    SUM(profitability) AS total_profitability
FROM insurance
GROUP BY stakeholder_name
ORDER BY total_profitability DESC;
