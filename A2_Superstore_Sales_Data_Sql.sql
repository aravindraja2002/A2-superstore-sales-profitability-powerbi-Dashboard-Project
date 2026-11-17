# 1. Create and Select Database
CREATE DATABASE IF NOT EXISTS superstore_sales_db;
USE superstore_sales_db;

SELECT COUNT(*) FROM sample_superstore ;

USE superstore_sales_db;

# Query 1: Executive KPI Overview (Sales, Profit, Margin & Orders)
SELECT 
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    COUNT(DISTINCT `Customer ID`) AS Total_Customers,
    SUM(`Quantity`) AS Total_Quantity_Sold,
    ROUND(SUM(`Sales`), 2) AS Total_Revenue,
    ROUND(SUM(`Profit`), 2) AS Total_Profit,
    ROUND((SUM(`Profit`) / SUM(`Sales`)) * 100, 2) AS Overall_Profit_Margin_Pct,
    ROUND(AVG(`Discount`) * 100, 2) AS Avg_Discount_Pct
FROM sample_superstore;

# Query 2: Regional Performance & Profitability
SELECT 
    `Region`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    SUM(`Quantity`) AS Units_Sold,
    ROUND(SUM(`Sales`), 2) AS Regional_Sales,
    ROUND(SUM(`Profit`), 2) AS Regional_Profit,
    ROUND((SUM(`Profit`) / SUM(`Sales`)) * 100, 2) AS Profit_Margin_Pct
FROM sample_superstore
GROUP BY `Region`
ORDER BY Regional_Sales DESC;

# Query 3: Category & Sub-Category Performance
SELECT 
    `Category`,
    `Sub-Category`,
    SUM(`Quantity`) AS Units_Sold,
    ROUND(SUM(`Sales`), 2) AS Total_Sales,
    ROUND(SUM(`Profit`), 2) AS Total_Profit,
    ROUND((SUM(`Profit`) / SUM(`Sales`)) * 100, 2) AS Profit_Margin_Pct
FROM sample_superstore
GROUP BY `Category`, `Sub-Category`
ORDER BY `Category`, Total_Sales DESC;

# Query 4: Top 5 High-Revenue Generating Products
SELECT 
    `Product Name`,
    `Category`,
    SUM(`Quantity`) AS Total_Units_Sold,
    ROUND(SUM(`Sales`), 2) AS Total_Revenue,
    ROUND(SUM(`Profit`), 2) AS Net_Profit
FROM sample_superstore
GROUP BY `Product Name`, `Category`
ORDER BY Total_Revenue DESC
LIMIT 5;

# Query 5: Discount Impact & Loss Analysis
SELECT 
    CASE 
        WHEN `Discount` = 0 THEN 'No Discount (0%)'
        WHEN `Discount` <= 0.2 THEN 'Low Discount (1-20%)'
        WHEN `Discount` <= 0.4 THEN 'Medium Discount (21-40%)'
        ELSE 'High Discount (>40%)'
    END AS Discount_Bracket,
    COUNT(`Row ID`) AS Total_Transactions,
    ROUND(SUM(`Sales`), 2) AS Total_Sales,
    ROUND(SUM(`Profit`), 2) AS Total_Profit,
    ROUND((SUM(`Profit`) / SUM(`Sales`)) * 100, 2) AS Margin_Pct
FROM sample_superstore
GROUP BY Discount_Bracket
ORDER BY Total_Sales DESC;
