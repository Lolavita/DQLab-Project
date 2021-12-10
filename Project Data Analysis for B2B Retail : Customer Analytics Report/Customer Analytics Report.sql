#Total Penjualan dan Revenue pada Q1 dan Q2

SELECT SUM(quantity) AS total_penjualan, 
SUM(quantity * priceeach) AS revenue 
FROM orders_1 
WHERE status="Shipped";

SELECT SUM(quantity) AS total_penjualan, 
SUM(quantity * priceeach) AS revenue 
FROM orders_2 
WHERE status="Shipped";

#Menghitung persentasi keseluruhan penjualan

SELECT quarter, SUM(quantity)  AS total_penjualan, 
SUM(quantity*priceeach) AS revenue 
FROM (SELECT orderNumber, status, quantity, priceeach,'1'quarter
FROM orders_1 UNION SELECT orderNumber, status, quantity, priceeach,'2'quarter FROM orders_2) AS orders1_2 
WHERE status="Shipped" 
GROUP BY quarter;

#Mengecek apakah jumlah customers xyz.com semakin bertambah

SELECT quarter, COUNT(DISTINCT customerID) total_customers 
FROM (SELECT customerID, createDate, QUARTER(createDate) quarter 
FROM customer 
WHERE createDate between '2004-01-01' AND '2004-06-30') cust 
GROUP BY quarter;

#Mengecek seberapa banyak customers tersebut yang sudah melakukan transaksi

SELECT quarter, COUNT(DISTINCT customerID) total_customers 
FROM (SELECT customerID, createDate, QUARTER(createDate) quarter  
FROM customer 
WHERE createDate between '2004-01-01' AND '2004-06-30') tabel_b 
WHERE customerID IN (SELECT customerID FROM orders_1 UNION SELECT customerID FROM orders_2) 
GROUP BY quarter;

#Mengecek category produk apa saja yang paling banyak di-order oleh customers di Q2

SELECT left(productCode,3) categoryid, COUNT(DISTINCT orderNumber) total_order, SUM(quantity) total_penjualan 
FROM(SELECT productCode, orderNumber, quantity, status FROM orders_2 WHERE status="Shipped") tabel_c 
GROUP BY categoryID 
ORDER BY total_order DESC;

#Menghitung total unik customers yang transaksi di quarter_1

SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;

#Mengecek seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertama

SELECT '1' quarter, COUNT(DISTINCT customerID)*100/25 Q2 
FROM orders_1 
WHERE customerID IN(SELECT DISTINCT customerID FROM orders_2)

