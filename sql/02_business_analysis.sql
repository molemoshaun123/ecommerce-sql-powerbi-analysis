-- Day 3: Exploratory Data Analysis & Business Metrics (PostgreSQL 18)
-- Database: olist_ecommerce

-- 1. Order Status Distribution & Percentage Share
SELECT 
    order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 2. Monthly Realized Revenue & Month-over-Month (MoM) Growth (Delivered Orders Only)
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS order_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price) AS product_revenue,
        SUM(oi.freight_value) AS freight_revenue,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
)
SELECT 
    order_month,
    total_orders,
    ROUND(product_revenue, 2) AS product_revenue,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY order_month)) * 100.0 /
        NULLIF(LAG(total_revenue) OVER (ORDER BY order_month), 0),
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY order_month;

-- 3. Regional Revenue Performance & Average Order Value (AOV) by State (Top 10)
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(
        SUM(oi.price + oi.freight_value) * 100.0 / 
        SUM(SUM(oi.price + oi.freight_value)) OVER(), 
        2
    ) AS revenue_share_pct,
    ROUND(
        SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 
        2
    ) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. Delivery SLA & Late Delivery Rate by State (States with >= 500 Delivered Orders)
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 86400.0), 
        1
    ) AS avg_delivery_days,
    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_estimated_delivery_date - o.order_purchase_timestamp)) / 86400.0), 
        1
    ) AS avg_estimated_days,
    COUNT(DISTINCT CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN o.order_id 
    END) AS late_orders,
    ROUND(
        COUNT(DISTINCT CASE 
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN o.order_id 
        END) * 100.0 / COUNT(DISTINCT o.order_id), 
        2
    ) AS late_delivery_pct
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.order_id) >= 500
ORDER BY late_delivery_pct DESC;

-- 5. Power BI Analytical Views
CREATE OR REPLACE VIEW vw_monthly_sales AS
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS order_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(oi.price), 2) AS product_revenue,
        ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
)
SELECT 
    order_month,
    total_orders,
    product_revenue,
    freight_revenue,
    total_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY order_month)) * 100.0 /
        NULLIF(LAG(total_revenue) OVER (ORDER BY order_month), 0),
        2
    ) AS mom_growth_pct
FROM monthly_sales;

CREATE OR REPLACE VIEW vw_state_performance AS
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
    ROUND(AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 86400.0), 1) AS avg_delivery_days,
    ROUND(AVG(EXTRACT(EPOCH FROM (o.order_estimated_delivery_date - o.order_purchase_timestamp)) / 86400.0), 1) AS avg_estimated_days,
    COUNT(DISTINCT CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN o.order_id END) AS late_orders,
    ROUND(
        COUNT(DISTINCT CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN o.order_id END) * 100.0 /
        COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_pct
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state;
