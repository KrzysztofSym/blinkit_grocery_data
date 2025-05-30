CREATE database blinkit_db;
USE blinkit_db;
DROP TABLE IF EXISTS blinkit_data;
CREATE TABLE blinkit_data (
	item_fat_content VARCHAR(50),
    item_identifier VARCHAR(50),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(50),
    outlet_location_type VARCHAR(20),
    outlet_size VARCHAR(20),
    item_visibility DOUBLE,
    item_weight DOUBLE,
    sales DOUBLE,
    rating DOUBLE
    );
    
ALTER TABLE blinkit_data
ADD COLUMN outlet_type VARCHAR(50) AFTER outlet_size;

ALTER TABLE blinkit_data
MODIFY item_weight DOUBLE NULL;

SELECT * FROM blinkit_data;

SELECT * FROM blinkit_data;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Blinkit_cleaned.csv'
INTO TABLE blinkit_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(item_fat_content, item_identifier, item_type, outlet_establishment_year, outlet_identifier, outlet_location_type, outlet_size, outlet_type, item_visibility, @item_weight, sales, rating)
SET item_weight = NULLIF(@item_weight, '');

SHOW VARIABLES LIKE 'secure_file_priv';
