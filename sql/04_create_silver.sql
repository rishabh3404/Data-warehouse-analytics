USE DataWarehouseAnalytics;
GO

CREATE TABLE silver.customers
(
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(20),
    country VARCHAR(100),
    signup_date DATE,
    email VARCHAR(150)
);

CREATE TABLE silver.products
(
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    unit_price DECIMAL(12,2)
);

CREATE TABLE silver.orders
(
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATE,
    status VARCHAR(30)
);

CREATE TABLE silver.order_items
(
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(12,2)
);
GO
