import pandas as pd

# 1. Load orders and order_items
orders: pd.DataFrame = pd.read_csv("olist_orders_dataset.csv")
order_items: pd.DataFrame = pd.read_csv("olist_order_items_dataset.csv")

# 2. Filter to delivered orders and merge with order_items
delivered: pd.DataFrame = orders[orders["order_status"] == "delivered"].copy()
merged: pd.DataFrame = pd.merge(delivered, order_items, on="order_id", how="inner")

# 3. Group by product_id and calculate total_revenue, times_ordered, avg_unit_price
product_summary: pd.DataFrame = (
    merged.groupby("product_id", as_index=False)
    .agg(
        total_revenue=("price", "sum"),
        times_ordered=("order_id", "count"),
        avg_unit_price=("price", "mean")
    )
    .sort_values(by="total_revenue", ascending=False)
)

# 4. Round decimals and print top 5
product_summary["total_revenue"] = product_summary["total_revenue"].round(2)
product_summary["avg_unit_price"] = product_summary["avg_unit_price"].round(2)

print("Top 5 Products by Revenue:")
print(product_summary.head(5).to_string(index=False))

# 5. Export top 20 products to CSV for Power BI
product_summary.head(20).to_csv("clean_top_products.csv", index=False)
print("\nSaved clean_top_products.csv successfully!")