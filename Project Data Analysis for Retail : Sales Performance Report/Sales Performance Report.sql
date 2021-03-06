#Overall performance by Year

SELECT year(order_date) AS years, 
SUM(sales) AS sales, 
COUNT (order_id) AS number_of_order 
from dqlab_sales_store 
where order_status = "Order Finished" 
GROUP BY year(order_date);

#Overall Performance by Product Sub Category

SELECT year(order_date) AS years,
product_sub_category,
SUM(sales) AS sales 
FROM dqlab_sales_store 
WHERE year(order_date) BETWEEN 2011 AND 2012 
AND order_status = "Order Finished" 
GROUP BY year(order_date), product_sub_category 
ORDER BY year(order_date), sales DESC;

#Promotion Effectiveness and Efficiency by Years

SELECT year(order_date) AS years,
SUM(sales) AS sales, 
SUM(discount_value) AS promotion_value,
ROUND((ROUND(SUM(discount_value),2)/ROUND(SUM(sales),2))*100,2) AS burn_rate_percentage 
FROM dqlab_sales_store 
WHERE order_status = "Order Finished"
GROUP BY year(order_date) 
ORDER BY year(order_date);

#Promotion Effectiveness and Efficiency by Product Sub Category

SELECT year(order_date) AS years,
product_sub_category, 
product_category,
SUM(sales) as sales,
SUM(discount_value) AS promotion_value, 
ROUND((ROUND(SUM(discount_value),2)/ROUND(SUM(sales),2))*100,2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE year(order_date) = 2012 AND order_status = "Order Finished"
GROUP BY product_category, product_sub_category, year(order_date) 
ORDER BY sales DESC;

#Customers Transactions per Year

SELECT year(order_date) AS years, 
COUNT(distinct lower(customer)) AS number_of_customer 
FROM dqlab_sales_store 
WHERE order_status = "Order Finished" 
GROUP BY year(order_date);
