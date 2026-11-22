# 🐍 Python (pandas) Data Cleaning & EDA Walkthrough

This document compiles the complete Day 4 exploratory data analysis (EDA) pipeline, code walkthrough, and verified execution outputs using `pandas` on the Brazilian E-Commerce dataset (Olist).

All scripts live in [`python-eda/`](file:///c:/Users/Test/Desktop/sql/python-eda) alongside clean, Power BI-ready exported CSVs.

---

## 📑 Table of Contents
1. [Step 1: Ingestion & Schema Inspection (`step1_load.py`)](#step-1-ingestion--schema-inspection)
2. [Step 2: Datetime Conversion, SLA Calculation & Data Quality Audit (`step2_clean_dates.py`)](#step-2-datetime-conversion-sla-calculation--data-quality-audit)
3. [Step 3: Multi-Table Merge, Aggregation & Regional Export (`step3_merge_groupby.py`)](#step-3-multi-table-merge-aggregation--regional-export)
4. [Step 4: Product Revenue Analysis & High-Value Export (`step4_top_products.py`)](#step-4-product-revenue-analysis--high-value-export)

---

## Step 1: Ingestion & Schema Inspection

### Script: `python-eda/step1_load.py`
```python
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
```

### Verified Terminal Output
```text
Shape (rows, columns): (99441, 8)

Column types:
order_id                         object
customer_id                      object
order_status                     object
order_purchase_timestamp         object
order_approved_at                object
order_delivered_carrier_date     object
order_delivered_customer_date    object
order_estimated_delivery_date    object
dtype: object

First 5 rows:
                           order_id                       customer_id order_status order_purchase_timestamp    order_approved_at order_delivered_carrier_date order_delivered_customer_date order_estimated_delivery_date
0  e481f51cbdc54678b7cc49136f2d6af7  9ef432eb6251297304e76186b10a928d    delivered       2017-10-02 10:56:33  2017-10-02 11:07:15          2017-10-04 19:55:00           2017-10-10 21:25:13           2017-10-18 00:00:00
1  53cdb2fc8bc7dce0b6741e2150273451  b0830fb4747a6c6d20dea0b8c802d7ef    delivered       2018-07-24 20:41:37  2018-07-26 03:24:27          2018-07-26 15:31:00           2018-08-07 15:27:45           2018-08-13 00:00:00
2  47770eb9100c2d0c44946d9cf07ec65d  41ce2a54c0b0fb33e16bc7b0504d1c49    delivered       2018-08-08 08:38:49  2018-08-08 08:55:23          2018-08-08 13:50:00           2018-08-17 18:06:29           2018-09-04 00:00:00
3  949d5b44dbf5de918fe9c16f97b45f8a  f88197465ea7920adcdbec7375364d82    delivered       2017-11-18 19:28:06  2017-11-18 19:45:59          2017-11-22 13:39:59           2017-12-02 00:28:42           2017-12-15 00:00:00
4  ad21c59c0840e6cb83f9ceee7763f0fe  9a0e5139a5e276224854ba59ca644952    delivered       2018-02-13 21:18:39  2018-02-13 22:20:29          2018-02-14 19:46:34           2018-02-16 18:17:02           2018-02-26 00:00:00
```
> **Key Insight:** In raw CSV ingestion, all 5 timestamp columns are loaded as generic string `object` types, necessitating explicit datetime casting for SLA computation.

---

## Step 2: Datetime Conversion, SLA Calculation & Data Quality Audit

### Script: `python-eda/step2_clean_dates.py`
```python
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
```

### Verified Terminal Output
```text
Updated date column types:
order_purchase_timestamp         datetime64[ns]
order_delivered_customer_date    datetime64[ns]
dtype: object

Total delivered orders: 96478

Delivery summary (in days):
       delivery_days  delay_vs_estimate
count       96470.00           96470.00
mean          12.09             -11.88
std            9.55              10.18
min            0.00            -147.00
25%            6.00             -16.00
50%           10.00             -12.00
75%           15.00              -7.00
max          209.00             188.00
```
> **Key Data Quality Finding:** Total delivered orders count is `96,478`, yet `delivery_days` has `96,470.00` valid entries. This immediately identifies **8 orders** marked with `order_status = 'delivered'` that have `null` timestamps for `order_delivered_customer_date`. Furthermore, deliveries arrive on average **11.88 days ahead** of estimated SLA (`delay_vs_estimate = -11.88`), with 50% arriving within 10 days of purchase.

---

## Step 3: Multi-Table Merge, Aggregation & Regional Export

### Script: `python-eda/step3_merge_groupby.py`
```python
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
```

### Verified Terminal Output
```text
Merged table shape (rows, columns): (110197, 19)

Top 10 States by Revenue:
customer_state  total_revenue  total_orders  avg_delivery_days
            SP     5067633.16         40501                8.3
            RJ     1759651.13         12350               14.7
            MG     1552481.83         11354               11.5
            RS      728897.47          5345               14.7
            PR      666063.51          4923               11.5
            SC      507012.13          3546               14.5
            BA      493584.14          3256               18.8
            DF      296498.41          2080               12.5
            GO      282836.70          1957               14.9
            ES      268643.45          1995               15.2

Saved clean_state_summary.csv successfully!
```
> **Output Artifact:** Clean summary exported to [`python-eda/clean_state_summary.csv`](file:///c:/Users/Test/Desktop/sql/python-eda/clean_state_summary.csv) for direct ingestion into Power BI.

---

## Step 4: Product Revenue Analysis & High-Value Export

### Script: `python-eda/step4_top_products.py`
```python
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
```

### Verified Terminal Output
```text
Top 5 Products by Revenue:
                      product_id  total_revenue  times_ordered  avg_unit_price
bb50f2e236e5eea0100680137654686c       63560.00            194          327.63
6cdd53843498f92890544667809f1595       53652.30            153          350.67
d6160fb7873f184099d9bc95e30376af       45949.35             33         1392.40
d1c427060a0f73f6b889a5c7c61f2ac4       45620.56            332          137.41
99a4788cb24856965c36a24e339b6058       42049.66            477           88.15

Saved clean_top_products.csv successfully!
```
> **Output Artifact:** Clean summary exported to [`python-eda/clean_top_products.csv`](file:///c:/Users/Test/Desktop/sql/python-eda/clean_top_products.csv) detailing top 20 revenue-generating SKUs for Power BI visual cards and Pareto analysis.
