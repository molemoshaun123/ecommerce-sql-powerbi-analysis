import pandas as pd

# 1. Load the orders dataset
orders: pd.DataFrame = pd.read_csv("olist_orders_dataset.csv")

# 2. Convert date text columns into real datetime objects
orders["order_purchase_timestamp"] = pd.to_datetime(orders["order_purchase_timestamp"])
orders["order_delivered_customer_date"] = pd.to_datetime(orders["order_delivered_customer_date"])
orders["order_estimated_delivery_date"] = pd.to_datetime(orders["order_estimated_delivery_date"])

# Verify the types changed from 'str' to 'datetime64'
print("Updated date column types:")
print(orders[["order_purchase_timestamp", "order_delivered_customer_date"]].dtypes)

# 3. Filter to 'delivered' orders only (SQL: WHERE order_status = 'delivered')
delivered: pd.DataFrame = orders[orders["order_status"] == "delivered"].copy()
print("\nTotal delivered orders:", len(delivered))

# 4. Calculate actual delivery days and delay vs. estimate
delivered["delivery_days"] = (
    delivered["order_delivered_customer_date"] - delivered["order_purchase_timestamp"]
).dt.days

delivered["delay_vs_estimate"] = (
    delivered["order_delivered_customer_date"] - delivered["order_estimated_delivery_date"]
).dt.days

# 5. Print summary statistics (mean, min, max)
print("\nDelivery summary (in days):")
print(delivered[["delivery_days", "delay_vs_estimate"]].describe().round(2))