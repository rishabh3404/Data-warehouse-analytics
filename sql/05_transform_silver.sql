USE DataWarehouseAnalytics;
GO

INSERT INTO silver.customers
SELECT
    TRIM(customer_id),
    TRIM(first_name),
    TRIM(last_name),
    TRIM(gender),
    TRIM(country),
    signup_date,
    LOWER(TRIM(email))
FROM bronze.customers
WHERE customer_id IS NOT NULL;


INSERT INTO silver.products
SELECT
    TRIM(product_id),
    TRIM(product_name),
    TRIM(category),
    unit_price
FROM bronze.products
WHERE product_id IS NOT NULL
AND unit_price >= 0;


INSERT INTO silver.orders
SELECT
    TRIM(order_id),
    TRIM(customer_id),
    order_date,
    TRIM(status)
FROM bronze.orders
WHERE order_id IS NOT NULL;


INSERT INTO silver.order_items
(
    order_id,
    product_id,
    quantity,
    unit_price
)
SELECT
    TRIM(order_id),
    TRIM(product_id),
    quantity,
    unit_price
FROM bronze.order_items
WHERE quantity > 0
AND unit_price >= 0;
GO
