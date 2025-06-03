SELECT * FROM blinkit_data;

SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_millions FROM blinkit_data;
SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_millions_LF FROM blinkit_data
WHERE item_fat_content = 'Low Fat'; -- Low Fat total

SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_millions_LF FROM blinkit_data
WHERE outlet_establishment_year = 2012;

SELECT CAST(AVG(sales) AS DECIMAL(10,0)) AS avg_sales FROM blinkit_data;

SELECT CAST(AVG(rating) AS DECIMAL(10,2)) AS AVG_Rating FROM blinkit_data;

SELECT COUNT(*) AS no_of_items FROM blinkit_data;