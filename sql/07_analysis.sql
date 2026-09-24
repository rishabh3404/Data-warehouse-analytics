USE DataWarehouseAnalytics;
GO

-- 1. Total Revenue
SELECT
    SUM(sales_amount) AS total_revenue
FROM gold.fact_sales;


-- 2. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM gold.fact_sales;


-- 3. Total Customers
SELECT
    COUNT(*) AS total_customers
FROM gold.dim_customer;


-- 4. Revenue by Country
SELECT
    c.country,
    SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY revenue DESC;


-- 5. Revenue by Product Category
SELECT
    p.category,
    SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;


-- 6. Top 5 Products
SELECT TOP 5
    p.product_name,
    SUM(f.quantity) AS units_sold,
    SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY revenue DESC;


-- 7. Monthly Revenue
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


-- 8. Average Order Value
SELECT
    CAST(
        SUM(sales_amount) /
        NULLIF(COUNT(DISTINCT order_id), 0)
        AS DECIMAL(12,2)
    ) AS average_order_value
FROM gold.fact_sales;


-- 9. Top 10 Customers
SELECT TOP 10
    c.customer_name,
    c.country,
    SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_name,
    c.country
ORDER BY revenue DESC;


-- 10. Category Revenue Contribution
SELECT
    p.category,
    SUM(f.sales_amount) AS revenue,
    CAST(
        100.0 * SUM(f.sales_amount)
        / SUM(SUM(f.sales_amount)) OVER ()
        AS DECIMAL(10,2)
    ) AS revenue_percentage
FROM gold.fact_sales f
JOIN gold.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;
