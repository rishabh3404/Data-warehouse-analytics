USE DataWarehouseAnalytics;
GO

BULK INSERT bronze.customers
FROM 'C:\DataWarehouseAnalytics\datasets\customers.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);

BULK INSERT bronze.products
FROM 'C:\DataWarehouseAnalytics\datasets\products.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);

BULK INSERT bronze.orders
FROM 'C:\DataWarehouseAnalytics\datasets\orders.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);

BULK INSERT bronze.order_items
FROM 'C:\DataWarehouseAnalytics\datasets\order_items.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO
