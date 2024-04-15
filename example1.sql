CREATE TABLE instruments(
	instrument VARCHAR(30),
	quantity int,
	buy_price FLOAT(10),
	current_price FLOAT(10)
);


INSERT INTO instruments VALUES ('NVIDIA', 10,	280.00, 		900.00   );
INSERT INTO instruments VALUES ('META', 10, 213.07, 		511.90   );
INSERT INTO instruments VALUES ('Amazon', 30, 102.41,	    186.13	 );
INSERT INTO instruments VALUES ('Apple', 30, 166.17, 		176.55   );
INSERT INTO instruments VALUES ('Tesla', 5,	194.77,		  171.05	 );
INSERT INTO instruments VALUES ('Netflix', 5,	348.28, 		622.83	 );
INSERT INTO instruments VALUES ('Alphabet', 20, 108.19, 		159.19   );
INSERT INTO instruments VALUES ('Snowflake', 20, 141.38, 		158.56	 );
INSERT INTO instruments VALUES ('Microsoft', 5, 289.84,     421.90	 );

--Print all records?
mysql> SELECT * FROM instruments;
+------------+----------+-----------+---------------+
| instrument | quantity | buy_price | current_price |
+------------+----------+-----------+---------------+
| NVIDIA     |       10 |       280 |           900 |
| META       |       10 |    213.07 |         511.9 |
| Amazon     |       30 |    102.41 |        186.13 |
| Apple      |       30 |    166.17 |        176.55 |
| Tesla      |        5 |    194.77 |        171.05 |
| Netflix    |        5 |    348.28 |        622.83 |
| Alphabet   |       20 |    108.19 |        159.19 |
| Snowflake  |       20 |    141.38 |        158.56 |
| Microsoft  |        5 |    289.84 |         421.9 |
+------------+----------+-----------+---------------+
  
-- Find total Invested Amount and Current Value, Total P&L

SELECT  ROUND(SUM(quantity * buy_price), 2) total_invested
       ,ROUND(SUM(quantity * current_price), 2) current_value
       ,ROUND(SUM(quantity * current_price)/SUM(quantity * buy_price) * 100  - 100 )  total_profit_and_Loss 
FROM instruments;
+----------------+---------------+-----------------------+
| total_invested | current_value | total_profit_and_Loss |
+----------------+---------------+-----------------------+
|       22143.95 |       37433.3 |                    69 |
+----------------+---------------+-----------------------+
-- Find total Invested Amount and Current Value, Total P&L for each instrument.

SELECT * , 
      ROUND((quantity * buy_price), 2) total_invested, 
      ROUND((quantity * current_price), 2) current_value, 
      ROUND(((current_price/buy_price) -1) * 100) `P&L`  
FROM instruments;

+------------+----------+-----------+---------------+----------------+---------------+------+
| instrument | quantity | buy_price | current_price | total_invested | current_value | P&L  |
+------------+----------+-----------+---------------+----------------+---------------+------+
| NVIDIA     |       10 |       280 |           900 |           2800 |          9000 |  221 |
| META       |       10 |    213.07 |         511.9 |         2130.7 |          5119 |  140 |
| Amazon     |       30 |    102.41 |        186.13 |         3072.3 |        5583.9 |   82 |
| Apple      |       30 |    166.17 |        176.55 |         4985.1 |        5296.5 |    6 |
| Tesla      |        5 |    194.77 |        171.05 |         973.85 |        855.25 |  -12 |
| Netflix    |        5 |    348.28 |        622.83 |         1741.4 |       3114.15 |   79 |
| Alphabet   |       20 |    108.19 |        159.19 |         2163.8 |        3183.8 |   47 |
| Snowflake  |       20 |    141.38 |        158.56 |         2827.6 |        3171.2 |   12 |
| Microsoft  |        5 |    289.84 |         421.9 |         1449.2 |        2109.5 |   46 |
+------------+----------+-----------+---------------+----------------+---------------+------+

-- Find Total Invested Amount and Current Value, Total P&L , investment weight and  current weight for each instrument

SELECT * , 
      ROUND((quantity * buy_price), 2) total_invested, 
      ROUND((quantity * current_price), 2) current_value, 
      ROUND(((current_price/buy_price) -1) * 100) `P&L`,
      ROUND( (quantity * buy_price)/SUM(quantity * buy_price) OVER()  * 100 , 2) investment_weight,
      ROUND( (quantity * current_price)/SUM(quantity * current_price) OVER()  * 100 , 2) current_value_weight
FROM instruments;
+------------+----------+-----------+---------------+----------------+---------------+------+-------------------+----------------------+
| instrument | quantity | buy_price | current_price | total_invested | current_value | P&L  | investment_weight | current_value_weight |
+------------+----------+-----------+---------------+----------------+---------------+------+-------------------+----------------------+
| NVIDIA     |       10 |       280 |           900 |           2800 |          9000 |  221 |             12.64 |                24.04 |
| META       |       10 |    213.07 |         511.9 |         2130.7 |          5119 |  140 |              9.62 |                13.67 |
| Amazon     |       30 |    102.41 |        186.13 |         3072.3 |        5583.9 |   82 |             13.87 |                14.92 |
| Apple      |       30 |    166.17 |        176.55 |         4985.1 |        5296.5 |    6 |             22.51 |                14.15 |
| Tesla      |        5 |    194.77 |        171.05 |         973.85 |        855.25 |  -12 |               4.4 |                 2.28 |
| Netflix    |        5 |    348.28 |        622.83 |         1741.4 |       3114.15 |   79 |              7.86 |                 8.32 |
| Alphabet   |       20 |    108.19 |        159.19 |         2163.8 |        3183.8 |   47 |              9.77 |                 8.51 |
| Snowflake  |       20 |    141.38 |        158.56 |         2827.6 |        3171.2 |   12 |             12.77 |                 8.47 |
| Microsoft  |        5 |    289.84 |         421.9 |         1449.2 |        2109.5 |   46 |              6.54 |                 5.64 |
+------------+----------+-----------+---------------+----------------+---------------+------+-------------------+----------------------+
