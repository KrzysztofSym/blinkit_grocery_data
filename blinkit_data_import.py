import pandas as pd
from sqlalchemy import create_engine
df = pd.read_csv("BlinkIT Grocery Data.csv", delimiter = ";")
for col in ['Item Visibility', 'Item Weight', 'Sales']:
    col_clean = col.strip()
    df[col_clean] = df[col_clean].str.replace(',', '.').astype(float)
df.to_csv("Blinkit_cleaned.csv", index = False)


# import pandas as pd

# # Load CSV with semicolon delimiter
# df = pd.read_csv('BlinkIT Grocery Data.csv', delimiter=';')

# # Print actual column names
# print("Columns in CSV:", df.columns.tolist())