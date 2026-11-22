import pandas as pd

# Load the orders CSV into a DataFrame (a table in Python)
orders: pd.DataFrame = pd.read_csv("olist_orders_dataset.csv")

# Print the number of rows and columns
print("Shape (rows, columns):", orders.shape)

# Print column names and their data types
print("\nColumn types:")
print(orders.dtypes)

# Print the first 5 rows
print("\nFirst 5 rows:")
print(orders.head())