# Power BI Data Modeling & Executive Dashboards

This directory contains the Power BI project files (`.pbix`), DAX calculation formulas, and exported data models.

## Upcoming Deliverables (Day 5 & Day 6)
- Star Schema data model connecting orders, customers, items, products, and payments.
- Core DAX Measures:
  - `Total Revenue = SUM(olist_order_payments[payment_value])`
  - `Total Orders = DISTINCTCOUNT(olist_orders[order_id])`
  - `Average Order Value (AOV) = DIVIDE([Total Revenue], [Total Orders], 0)`
  - `Late Delivery % = DIVIDE(CALCULATE(COUNTROWS(olist_orders), olist_orders[order_delivered_customer_date] > olist_orders[order_estimated_delivery_date]), [Total Orders], 0)`
- Executive Sales & Logistics single-page dashboard with high-res exports stored in `/images`.
