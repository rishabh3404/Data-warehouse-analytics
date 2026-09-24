USE DataWarehouseAnalytics;
GO

CREATE TABLE gold.dim_customer
(
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id VARCHAR(20),
    customer_name VARCHAR(201),
    gender VARCHAR(20),
    country VARCHAR(100),
    signup_date DATE,
    email VARCHAR(150)
);

CREATE TABLE gold.dim_product
(
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id VARCHAR(20),
    product_name VARCHAR(150),
    category VARCHAR(100),
    unit_price DECIMAL(12,2)
);

CREATE TABLE gold.dim_date
(
    date_key INT PRIMARY KEY,
    full_date DATE,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    day_name VARCHAR(20)
);

CREATE TABLE gold.fact_sales
(
    sales_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id VARCHAR(20),
    customer_key INT,
    product_key INT,
    date_key INT,
    quantity INT,
    unit_price DECIMAL(12,2),
    sales_amount DECIMAL(14,2),

    FOREIGN KEY (customer_key)
        REFERENCES gold.dim_customer(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES gold.dim_product(product_key),

    FOREIGN KEY (date_key)
        REFERENCES gold.dim_date(date_key)
);
GO

INSERT INTO gold.dim_customer
(
    customer_id,
    customer_name,
    gender,
    country,
    signup_date,
    email
)
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name),
    gender,
    country,
    signup_date,
    email
FROM silver.customers;

INSERT INTO gold.dim_product
(
    product_id,
    product_name,
    category,
    unit_price
)
SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM silver.products;
GO

DECLARE @StartDate DATE = '2025-01-01';
DECLARE @EndDate DATE = '2025-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO gold.dim_date
    (
        date_key,
        full_date,
        year,
        quarter,
        month,
        month_name,
        day,
        day_name
    )
    VALUES
    (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATENAME(WEEKDAY, @StartDate)
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);

END;
GO

INSERT INTO gold.fact_sales
(
    order_id,
    customer_key,
    product_key,
    date_key,
    quantity,
    unit_price,
    sales_amount
)
SELECT
    oi.order_id,
    c.customer_key,
    p.product_key,
    CONVERT(INT, FORMAT(o.order_date, 'yyyyMMdd')),
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price
FROM silver.order_items oi
INNER JOIN silver.orders o
    ON oi.order_id = o.order_id
INNER JOIN gold.dim_customer c
    ON o.customer_id = c.customer_id
INNER JOIN gold.dim_product p
    ON oi.product_id = p.product_id;
GO
