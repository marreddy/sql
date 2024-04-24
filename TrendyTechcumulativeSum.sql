--Write a SQL query to calculate the cumulative sum of the SaleAmount for each ProductID, ordered by SaleDate. 
--Howeaver the cumulative sum should reset to 0 whenever a new ProductID is encountered.
--https://www.youtube.com/watch?v=qpBG3psiwFE&t=673s

CREATE TABE transactions (
	transaction_id int,
	product_id int,
	sales_date date,
	sales_amt int
);

INSERT INTO transactions VALUES (1, 1, '2024-01-01', 100),(2,1,'2024-01-02', 150),(3,2,'2024-01-01', 200),(4,1,'2024-01-03', 120),(5,2,'2024-01-02', 180),(6,1,'2024-01-04', 90);

--One the interesting question asked in TrendyTech interview series. Try it
--Write a SQL query to calculate the cumulative sum of the SaleAmount for each ProductID, ordered by SaleDate. 
--However the cumulative sum should reset to 0 whenever a new ProductID is encountered.

--INPUT
mysql> SELECT * FROM transactions;
+----------------+------------+------------+-----------+
| transaction_id | product_id | sales_date | sales_amt |
+----------------+------------+------------+-----------+
|              1 |          1 | 2024-01-01 |       100 |
|              2 |          1 | 2024-01-02 |       150 |
|              3 |          2 | 2024-01-01 |       200 |
|              4 |          1 | 2024-01-03 |       120 |
|              5 |          2 | 2024-01-02 |       180 |
|              6 |          1 | 2024-01-04 |        90 |
+----------------+------------+------------+-----------+
6 rows in set (0.00 sec)  
--EXPECTED OUTPUT
+----------------+------------+------------+-----------+----------------+
| transaction_id | product_id | sales_date | sales_amt | cumulative_sum |
+----------------+------------+------------+-----------+----------------+
|              1 |          1 | 2024-01-01 |       100 |            100 |
|              2 |          1 | 2024-01-02 |       150 |            250 |
|              3 |          2 | 2024-01-01 |       200 |            200 |
|              4 |          1 | 2024-01-03 |       120 |            120 |
|              5 |          2 | 2024-01-02 |       180 |            180 |
|              6 |          1 | 2024-01-04 |        90 |             90 |
+----------------+------------+------------+-----------+----------------+

