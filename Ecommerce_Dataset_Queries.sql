--Display dataset
SELECT *
FROM EcommerceDataset;

-- See first 10 rows
SELECT *
FROM EcommerceDataset
LIMIT 10;

-- Count total rows
SELECT COUNT(*) AS total_orders
FROM EcommerceDataset;

-- Orders in 2018 with sales above 500
SELECT Order_Date, Customer_Id, Product, Sales
FROM EcommerceDataset
WHERE Order_Date LIKE '2018-%'
  AND Sales > 200
ORDER BY Sales DESC;

--Monthly sales totals
SELECT strftime('%Y-%m', Order_Date) AS month,
       SUM(Sales) AS total_sales
FROM EcommerceDataset
GROUP BY month
ORDER BY month;

--Sales by product category
SELECT Product_Category,
       SUM(Sales) AS total_sales,
       SUM(Quantity) AS total_quantity
FROM EcommerceDataset
GROUP BY Product_Category
ORDER BY total_sales DESC;

--Top 10 products by sales
SELECT Product,
       SUM(Sales) AS total_sales
FROM EcommerceDataset
GROUP BY Product
ORDER BY total_sales DESC
LIMIT 10;

-- Average profit by category
SELECT Product_Category,
       AVG(Profit) AS avg_profit
FROM EcommerceDataset
GROUP BY Product_Category
ORDER BY avg_profit DESC;

--Customers who bought the most
SELECT Customer_Id,
       SUM(Sales) AS total_spent
FROM EcommerceDataset
GROUP BY Customer_Id
ORDER BY total_spent DESC
LIMIT 10;

--Customers with the least discount purchases
SELECT DISTINCT Customer_Id
FROM EcommerceDataset
WHERE Discount = 0.1;

--Best-selling product per category
WITH category_sales AS (
    SELECT Product_Category,
           Product,
           SUM(Sales) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY Product_Category ORDER BY SUM(Sales) DESC) AS rn
    FROM EcommerceDataset
    GROUP BY Product_Category, Product
)
SELECT Product_Category, Product, total_sales
FROM category_sales
WHERE rn = 1;

--Sales by payment method
SELECT Payment_method,
       SUM(Sales) AS total_sales,
       COUNT(*) AS total_orders
FROM EcommerceDataset
GROUP BY Payment_method
ORDER BY total_sales DESC;

--Profit margin by category
SELECT Product_Category,
       ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM EcommerceDataset
GROUP BY Product_Category
ORDER BY profit_margin_percent DESC;

--High-priority orders
SELECT Order_Date, Product, Sales, Order_Priority
FROM EcommerceDataset
WHERE Order_Priority = 'High'
ORDER BY Sales DESC;




