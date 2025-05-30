import mysql.connector
import csv

# MySQL connection parameters - change these to your settings
conn = mysql.connector.connect(
    host='localhost',
    user='your_username',
    password='your_password',
    database='your_database'
)

cursor = conn.cursor()

# Step 1: Create table query
create_table_query = """
CREATE TABLE IF NOT EXISTS blinkit_data_2 (
    item_fat_content VARCHAR(50),
    item_identifier VARCHAR(50),
    item_type VARCHAR(100),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(50),
    outlet_location_type VARCHAR(50),
    outlet_size VARCHAR(50),
    outlet_type VARCHAR(50),
    item_visibility FLOAT,
    item_weight FLOAT,
    sales FLOAT,
    rating FLOAT
)
"""

cursor.execute(create_table_query)
conn.commit()

# Step 2: Prepare insert query
insert_query = """
INSERT INTO blinkit_data_2 (
    item_fat_content, item_identifier, item_type,
    outlet_establishment_year, outlet_identifier,
    outlet_location_type, outlet_size, outlet_type,
    item_visibility, item_weight, sales, rating
) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# Step 3: Read CSV and prepare data
csv_file_path = r'C:\Users\ksymoniuk\Documents\Dane\dokumenty\VS\Projects\Python\blinkit_grocery_data\Blinkit_cleaned.csv'

data_to_insert = []
with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        # Convert types as needed
        try:
            data_to_insert.append((
                row['item_fat_content'],
                row['item_identifier'],
                row['item_type'],
                int(row['outlet_establishment_year']),
                row['outlet_identifier'],
                row['outlet_location_type'],
                row['outlet_size'],
                row['outlet_type'],
                float(row['item_visibility']),
                float(row['item_weight']),
                float(row['sales']),
                float(row['rating'])
            ))
        except ValueError as e:
            print(f"Skipping row due to error: {e} - {row}")

# Step 4: Insert data in batches
cursor.executemany(insert_query, data_to_insert)
conn.commit()

# Step 5: Close connection
cursor.close()
conn.close()

print("Data imported successfully!")
