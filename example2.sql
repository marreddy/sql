 SELECT * FROM dataset;
+---------+--------+
| revenue | date   |
+---------+--------+
|    2000 | 1-Jan  |
|    3000 | 2-Jan  |
|   45000 | 22-Jan |
|   40000 | 2-Feb  |
|   13000 | 2-Mar  |
+---------+--------+
5 rows in set (0.00 sec)

-- From the above data set find cumulative revenue by month ?

SELECT revenue, DATE_FORMAT(first_date,'%b') month, SUM(revenue) OVER(ORDER BY first_date) cumulative_revenue FROM ( 
	SELECT SUM(revenue) revenue, STR_TO_DATE(date, '%e-%b') first_date  
	FROM dataset GROUP BY MONTH(first_date)
) tab;
+---------+-------+--------------------+
| revenue | month | cumulative_revenue |
+---------+-------+--------------------+
|   50000 | Jan   |              50000 |
|   40000 | Feb   |              90000 |
|   13000 | Mar   |             103000 |
+---------+-------+--------------------+
3 rows in set (0.00 sec)


