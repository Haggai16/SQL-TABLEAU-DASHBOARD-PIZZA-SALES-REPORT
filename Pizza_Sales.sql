
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value 
FROM pizza_sales

SELECT SUM(quantity) As Total_Pizza
FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))AS DECIMAL (10,2)) AS Average_Pizzas_Per_Order
FROM pizza_sales

--Hourly Trend for Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) as order_hour, SUM(quantity) as Total_pizzas_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


---Weekly Trend for Total Hours
SELECT DATEPART(ISO_WEEK, order_date) AS Week_number, YEAR(order_date) as Order_year,
COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

--Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS Total_Sales
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category 

SELECT pizza_size, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL(10,2)) AS Total_Sales
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_size 

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC 

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC 

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
