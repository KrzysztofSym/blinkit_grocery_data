USE blinkit_db;
SELECT * FROM blinkit_data;

-- Cleaning data - 1st column
-- SELECT DISTINCT item_fat_content FROM blinkit_data;
SET SQL_SAFE_UPDATES = 0; -- I haven't got primary key selected, to be allowed to make changes I have turn off safe mode;

UPDATE blinkit_data
SET item_fat_content = 
CASE
	WHEN item_fat_content IN ('LF', 'low fat') THEN 'Low Fat'
	WHEN item_fat_content = 'reg' THEN 'Regular'
	ELSE item_fat_content
END;

