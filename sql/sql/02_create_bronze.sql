USE DataWarehouseAnalytics;
GO

CREATE TABLE bronze.customers
(
    customer_id VARCHAR(20),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(20),
    country VARCHAR(100),
    signup_date DATE,
    email VARCHAR(150)
);

CREATE TABLE bronze.products
(
    product_id VARCHAR(20),
    product_name VARCHAR(150),
    category VARCHAR(100),
    unit_price DECIMAL(12,2)
);

CREATE TABLE bronze.orders
(
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    order_date DATE,
    status VARCHAR(30)
);

CREATE TABLE bronze.order_items
(
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(12,2)
);
GO
