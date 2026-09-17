-- Create the Churn database
CREATE DATABASE Churn;

-- Select the Churn database
USE Churn;

-- Find the city with the most customers
SELECT city, COUNT(*) as total_customers 
FROM Churn_Prediction 
GROUP BY city 
ORDER BY total_customers DESC 
LIMIT 1;

-- Find churn rate by occupation
SELECT occupation,
       COUNT(*) AS total_customers,
       SUM(churn) AS churned_customers,
       ROUND(AVG(churn) * 100, 2) AS churn_rate
FROM Churn_Prediction
GROUP BY occupation
ORDER BY churn_rate DESC;

-- Find cities with the most churned customers
SELECT city,
       COUNT(*) AS churned_customers
FROM Churn_Prediction
WHERE churn = 1
GROUP BY city
ORDER BY churned_customers DESC;


-- Find churn rate by age group
SELECT
    CASE
        WHEN age BETWEEN 1 AND 17 THEN '1-17'
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        WHEN age BETWEEN 66 AND 75 THEN '66-75'
        WHEN age BETWEEN 76 AND 85 THEN '76-85'
        ELSE '86+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(AVG(churn) * 100, 2) AS churn_rate
FROM Churn_Prediction
GROUP BY age_group
ORDER BY churn_rate DESC;

-- Find average balance of churned customers
SELECT
ROUND(AVG(current_balance),2) AS average_balance
FROM Churn_Prediction
WHERE churn=1;

-- Find average balance of retained customers
SELECT ROUND(AVG(current_balance), 2) AS average_balance
FROM Churn_Prediction
WHERE churn = 0;

-- Find branches with the highest churn rate
 
SELECT branch_code, 
       COUNT(*) AS total_customers, 
       SUM(churn) AS churned_customers, 
       ROUND(AVG(churn) * 100, 2) AS churn_rate 
FROM churn_prediction 
GROUP BY branch_code 
HAVING COUNT(*) >= 50
ORDER BY churn_rate DESC;

-- Find average balance by occupation
SELECT
    occupation,
    ROUND(AVG(current_balance), 2) AS average_balance
FROM Churn_Prediction
GROUP BY occupation
ORDER BY average_balance DESC;

-- Find top 10 branches by total balance
SELECT
    branch_code,
    COUNT(*) AS total_customers,
    ROUND(SUM(current_balance), 2) AS total_balance
FROM Churn_Prediction
GROUP BY branch_code
ORDER BY total_balance DESC
LIMIT 10;

-- Find top 10 cities by average balance
SELECT
    city,
    COUNT(*) AS total_customers,
    ROUND(AVG(current_balance), 2) AS average_balance
FROM Churn_Prediction
GROUP BY city
HAVING COUNT(*) >= 50
ORDER BY average_balance DESC
LIMIT 10;

-- Find occupation with the highest deposits
SELECT
    occupation,
    ROUND(SUM(current_month_credit), 2) AS total_deposits
FROM Churn_Prediction
GROUP BY Occupation
ORDER BY total_deposits DESC;

-- Find occupation with the highest spending
SELECT
    Occupation,
    ROUND(SUM(current_month_debit), 2) AS total_spending
FROM Churn_Prediction
GROUP BY Occupation
ORDER BY total_spending DESC;

-- Find customers whose balance increased
SELECT
    customer_id,
    previous_month_balance,
    current_month_balance,
    ROUND(current_month_balance - previous_month_balance, 2) AS balance_increase
FROM Churn_Prediction
WHERE current_month_balance > previous_month_balance
ORDER BY balance_increase DESC;

-- Count customers whose balance increased
SELECT
    COUNT(*) AS customers_balance_increased
FROM Churn_Prediction
WHERE current_month_balance > previous_month_balance;

-- Calculate total balance increase
SELECT
    ROUND(SUM(current_month_balance - previous_month_balance), 2) AS total_balance_increase
FROM Churn_Prediction
WHERE current_month_balance > previous_month_balance;

-- Find customers whose balance decreased
SELECT
    customer_id,
    previous_month_balance,
    current_month_balance,
    ROUND(previous_month_balance - current_month_balance, 2) AS balance_decrease,
    COUNT(*) OVER () AS total_customers_decreased,
    ROUND(SUM(previous_month_balance - current_month_balance) OVER (), 2) AS total_balance_decrease
FROM Churn_Prediction
WHERE current_month_balance < previous_month_balance
ORDER BY balance_decrease DESC;


-- Find customers with no last transaction
SELECT
    customer_id,
    last_transaction,
    COUNT(*) OVER () AS total_customers_no_last_transaction
FROM Churn_Prediction
WHERE last_transaction = 'NAT';

-- Find average balance by gender
SELECT
    Gender,
    ROUND(AVG(current_balance), 2) AS average_balance
FROM Churn_Prediction
GROUP BY Gender
ORDER BY average_balance DESC;

-- Find average balance by age group
SELECT
    CASE
        WHEN age BETWEEN 1 AND 17 THEN '1-17'
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        WHEN age BETWEEN 66 AND 75 THEN '66-75'
        WHEN age BETWEEN 76 AND 85 THEN '76-85'
        ELSE '86+'
    END AS age_group,
    ROUND(AVG(current_balance), 2) AS average_balance
FROM Churn_Prediction
GROUP BY age_group
ORDER BY average_balance DESC;

-- Find cities with the highest average monthly credit
SELECT
    City,
    ROUND(AVG(current_month_credit), 2) AS average_monthly_credit
FROM Churn_Prediction
GROUP BY City
ORDER BY average_monthly_credit DESC
LIMIT 10;

-- Find cities with the highest average monthly debit
SELECT
    City,
    ROUND(AVG(current_month_debit), 2) AS average_monthly_debit
FROM Churn_Prediction
GROUP BY City
ORDER BY average_monthly_debit DESC
LIMIT 10;

-- Find average account balance by occupation
SELECT
    Occupation,
    ROUND(AVG(current_balance), 2) AS average_account_balance
FROM Churn_Prediction
GROUP BY Occupation
ORDER BY average_account_balance DESC;