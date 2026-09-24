# Data Warehouse & Analytics

An end-to-end SQL Server data warehouse project built using Medallion Architecture, ETL, Star Schema, and analytical SQL.

## 📌 Project Overview

This project demonstrates a complete data warehousing workflow from raw CSV data to business-ready analytical tables.

The solution follows a three-layer Medallion Architecture:

**Bronze → Silver → Gold**

The Gold layer uses a Star Schema containing fact and dimension tables for analytical reporting.

## 🎯 Objectives

- Build a SQL Server data warehouse
- Implement Bronze, Silver, and Gold layers
- Perform ETL transformations
- Clean and standardize raw data
- Implement Star Schema modeling
- Create fact and dimension tables
- Perform business analysis using SQL
- Generate sales, customer, product, and time-based insights

## 🛠️ Technology Stack

- SQL Server
- T-SQL
- CSV
- ETL
- Data Warehousing
- Medallion Architecture
- Star Schema
- SQL Joins
- Window Functions
- Aggregations

## 🏗️ Architecture

### Bronze Layer

Raw source data is loaded from CSV files with minimal transformation.

Source files:

- customers.csv
- products.csv
- orders.csv
- order_items.csv

### Silver Layer

The Silver layer cleans and standardizes the Bronze data.

Examples:

- Trimmed text values
- Standardized email addresses
- Validated quantities
- Validated prices
- Filtered invalid records

### Gold Layer

The Gold layer contains business-ready analytical tables.

Tables:

- `gold.dim_customer`
- `gold.dim_product`
- `gold.dim_date`
- `gold.fact_sales`

## ⭐ Star Schema

```text
                  dim_customer
                       |
                       |
dim_product ---- fact_sales ---- dim_date
