USE blinkit_db;
SELECT * FROM blinkit_data;

SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_millions FROM blinkit_data;
SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_millions_LF FROM blinkit_data
WHERE item_fat_content = 'Low Fat'; -- Low Fat total

SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_millions_LF FROM blinkit_data
WHERE outlet_establishment_year = 2012;

SELECT CAST(AVG(sales) AS DECIMAL(10,0)) AS avg_sales FROM blinkit_data;

SELECT CAST(AVG(rating) AS DECIMAL(10,2)) AS AVG_Rating FROM blinkit_data;

SELECT COUNT(*) AS no_of_items FROM blinkit_data; 

-- Total Sales by Fat Content
	-- Analyze the impact of fat content on total sales.
    -- ASSESS how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
SELECT item_fat_content,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
	CAST(AVG(sales) AS DECIMAL(10,1)) AS avg_sales,
    COUNT(*) AS No_of_items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit_data
WHERE outlet_establishment_year = 2020 -- optional, only when you want to check specific year
GROUP BY item_fat_content
ORDER BY total_sales DESC;

-- Total Sales by Item Type
	-- Identyfi the performance of different item types in terms of total sales.
    -- Assess hot other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content
SELECT item_type,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(AVG(sales) AS DECIMAL(10,1)) AS avg_sales,
    COUNT(*) AS No_of_items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit_data
GROUP BY item_type
ORDER BY total_sales DESC
LIMIT 5;

-- Fat Content by Outlet for Total Sales:
	-- Compare total sales across different outlets segmented by fat content.
    -- Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
SELECT 
  outlet_location_type,
  CAST(SUM(CASE WHEN item_fat_content = 'Low Fat' THEN sales ELSE 0 END) AS DECIMAL (10,2)) AS Low_Fat,
  CAST(SUM(CASE WHEN item_fat_content = 'Regular' THEN sales ELSE 0 END) AS DECIMAL (10,2)) AS Regular
FROM 
  blinkit_data
GROUP BY outlet_location_type
ORDER BY outlet_location_type;
    
-- Total Sales by Outlet Establishment
	-- Evaluate how the age or type of outlet establishment influences total sales.
SELECT outlet_establishment_year,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(AVG(sales) AS DECIMAL(10,1)) AS avg_sales,
    COUNT(*) AS No_of_items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit_data
GROUP BY 1
ORDER BY 1;

-- Percentage of Sales by Outlet Size
	-- Analyze the correlation between outlet size and total sales.
SELECT
	outlet_size,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
    ROUND(SUM(sales) * 100 / (SELECT SUM(sales) FROM blinkit_data), 2) AS sales_percentage
FROM blinkit_data
GROUP BY outlet_size;
	-- Different approach
SELECT 
    outlet_size,
    total_sales,
    ROUND(total_sales * 100 / total_overall_sales, 2) AS sales_percentage
FROM (
    SELECT 
        outlet_size,
        ROUND(SUM(sales), 2) AS total_sales,
        SUM(SUM(sales)) OVER() AS total_overall_sales
    FROM 
        blinkit_data
    GROUP BY 
        outlet_size
) AS sales_data;

-- Sales by Outlet Location
	-- Assess the geographic distribution of sales across different locations.
SELECT outlet_location_type,
	ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(sales) * 100 / (SELECT SUM(sales) FROM blinkit_data), 2) AS sales_percentage,
    CAST(AVG(sales) AS DECIMAL(10,1)) AS avg_sales,
    COUNT(*) AS No_of_items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit_data
GROUP BY 1
ORDER BY total_sales DESC;
-- All Metrics by Outlet Type
	-- Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of Items, Average Rating) broken down by different outlet types.

