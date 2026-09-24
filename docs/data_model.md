# Data Model

The project follows a Star Schema design.

## Fact Table

### gold.fact_sales

Contains transactional sales information.

Columns:

- sales_key
- order_id
- customer_key
- product_key
- date_key
- quantity
- unit_price
- sales_amount

## Dimension Tables

### gold.dim_customer

Stores customer information.

### gold.dim_product

Stores product and category information.

### gold.dim_date

Stores calendar attributes used for time-based analysis.

## Relationships

```text
                 dim_customer
                      |
                      |
dim_product ---- fact_sales ---- dim_date
