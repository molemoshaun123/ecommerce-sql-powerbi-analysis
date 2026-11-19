-- ==============================================================================
-- Day 2: Database Design & Schema Setup for Olist E-Commerce
-- Database: olist_ecommerce
-- Engine: PostgreSQL
-- ==============================================================================

-- Drop tables if they already exist (in reverse dependency order)
DROP TABLE IF EXISTS olist_order_reviews CASCADE;
DROP TABLE IF EXISTS olist_order_payments CASCADE;
DROP TABLE IF EXISTS olist_order_items CASCADE;
DROP TABLE IF EXISTS olist_orders CASCADE;
DROP TABLE IF EXISTS olist_products CASCADE;
DROP TABLE IF EXISTS olist_sellers CASCADE;
DROP TABLE IF EXISTS olist_customers CASCADE;
DROP TABLE IF EXISTS olist_geolocation CASCADE;

-- 1. Customers Table
CREATE TABLE olist_customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(5)
);

-- 2. Geolocation Table
CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC(10, 8),
    geolocation_lng NUMERIC(11, 8),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(5)
);

-- 3. Sellers Table
CREATE TABLE olist_sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(5)
);

-- 4. Products Table
CREATE TABLE olist_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g NUMERIC(10, 2),
    product_length_cm NUMERIC(10, 2),
    product_height_cm NUMERIC(10, 2),
    product_width_cm NUMERIC(10, 2)
);

-- 5. Orders Table
CREATE TABLE olist_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) REFERENCES olist_customers(customer_id),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- 6. Order Items Table
CREATE TABLE olist_order_items (
    order_id VARCHAR(50) REFERENCES olist_orders(order_id),
    order_item_id INT,
    product_id VARCHAR(50) REFERENCES olist_products(product_id),
    seller_id VARCHAR(50) REFERENCES olist_sellers(seller_id),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2),
    PRIMARY KEY (order_id, order_item_id)
);

-- 7. Order Payments Table
CREATE TABLE olist_order_payments (
    order_id VARCHAR(50) REFERENCES olist_orders(order_id),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value NUMERIC(10, 2),
    PRIMARY KEY (order_id, payment_sequential)
);

-- 8. Order Reviews Table
CREATE TABLE olist_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50) REFERENCES olist_orders(order_id),
    review_score INT CHECK (review_score BETWEEN 1 AND 5),
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id)
);

-- Indexes for Query Performance (Joins & Filter Speed)
CREATE INDEX idx_orders_customer_id ON olist_orders(customer_id);
CREATE INDEX idx_orders_purchase_timestamp ON olist_orders(order_purchase_timestamp);
CREATE INDEX idx_order_items_product_id ON olist_order_items(product_id);
CREATE INDEX idx_order_items_seller_id ON olist_order_items(seller_id);
CREATE INDEX idx_order_payments_order_id ON olist_order_payments(order_id);
CREATE INDEX idx_order_reviews_order_id ON olist_order_reviews(order_id);

-- Instructions for Data Loading (Run via psql command or pgAdmin Import tool):
-- \copy olist_customers FROM 'data/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_geolocation FROM 'data/olist_geolocation_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_sellers FROM 'data/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_products FROM 'data/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_orders FROM 'data/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_order_items FROM 'data/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_order_payments FROM 'data/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true);
-- \copy olist_order_reviews FROM 'data/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true);
