-- Database: olist_ecommerce (PostgreSQL 18)

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(5)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) REFERENCES customers(customer_id),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR(50) REFERENCES orders(order_id),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2),
    PRIMARY KEY (order_id, order_item_id)
);

-- Client-side bulk ingestion via psql \copy (UTF-8)
-- \copy customers FROM 'data/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
-- \copy orders FROM 'data/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
-- \copy order_items FROM 'data/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- Row count verification
SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;
