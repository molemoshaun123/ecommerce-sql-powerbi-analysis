import pandas as pd

# 1. Load all three datasets
orders: pd.DataFrame = pd.read_csv("olist_orders_dataset.csv")
order_items: pd.DataFrame = pd.read_csv("olist_order_items_dataset.csv")
customers: pd.DataFrame = pd.read_csv("olist_customers_dataset.csv")

# 2. Convert timestamps and filter to delivered orders
orders["order_purchase_timestamp"] = pd.to_datetime(orders["order_purchase_timestamp"])
orders["order_delivered_customer_date"] = pd.to_datetime(orders["order_delivered_customer_date"])

delivered: pd.DataFrame = orders[orders["order_status"] == "delivered"].copy()
delivered["delivery_days"] = (
    delivered["order_delivered_customer_date"] - delivered["order_purchase_timestamp"]
).dt.days

# 3. Join tables (SQL: INNER JOIN order_items ON order_id INNER JOIN customers ON customer_id)
merged: pd.DataFrame = pd.merge(delivered, order_items, on="order_id", how="inner")
merged = pd.merge(merged, customers, on="customer_id", how="inner")

print("Merged table shape (rows, columns):", merged.shape)

# 4. Group by customer_state (SQL: GROUP BY customer_state)
state_summary: pd.DataFrame = (
    merged.groupby("customer_state", as_index=False)
    .agg(
        total_revenue=("price", "sum"),
        total_orders=("order_id", "nunique"),
        avg_delivery_days=("delivery_days", "mean")
    )
    .sort_values(by="total_revenue", ascending=False)
)

# Round decimals for clean display
state_summary["total_revenue"] = state_summary["total_revenue"].round(2)
state_summary["avg_delivery_days"] = state_summary["avg_delivery_days"].round(1)

print("\nTop 10 States by Revenue:")
print(state_summary.head(10).to_string(index=False))

# 5. Export clean summary to CSV for Power BI
state_summary.to_csv("clean_state_summary.csv", index=False)
print("\nSaved clean_state_summary.csv successfully!")