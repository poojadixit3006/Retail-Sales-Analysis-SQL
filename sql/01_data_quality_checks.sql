/*
====================================================
Retail Sales SQL Analysis
File: 01_data_quality_checks.sql
Purpose: Data Quality and Validation Checks
====================================================
*/

/*
1. Check available tables
*/

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'retail'
ORDER BY table_name;

/*
2. Check row counts
*/

SELECT
    'customers' AS table_name,
    COUNT(*) AS total_rows
FROM retail.customers

UNION ALL

SELECT
    'products' AS table_name,
    COUNT(*) AS total_rows
FROM retail.products

UNION ALL

SELECT
    'sales' AS table_name,
    COUNT(*) AS total_rows
FROM retail.sales;


/*
3. Check duplicate customer IDs
*/

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM retail.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

/*
4. Check duplicate product IDs
*/

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM retail.products
GROUP BY product_id
HAVING COUNT(*) > 1;

/*
5. Check duplicate order IDs
*/

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM retail.sales
GROUP BY order_id
HAVING COUNT(*) > 1;

/*
6. Check sales date range
*/

SELECT
    MIN(order_date) AS start_date,
    MAX(order_date) AS end_date
FROM retail.sales;

/*
7. Check missing values in sales table
*/

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
    COUNT(*) FILTER (WHERE ship_date IS NULL) AS missing_ship_date,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE cost IS NULL) AS missing_cost,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM retail.sales;

/*
8. Check missing values in customers table
*/

SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE customer_name IS NULL) AS missing_customer_name,
    COUNT(*) FILTER (WHERE segment IS NULL) AS missing_segment
FROM retail.customers;

/*
9. Check missing values in products table
*/

SELECT
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE product_name IS NULL) AS missing_product_name,
    COUNT(*) FILTER (WHERE category IS NULL) AS missing_category,
    COUNT(*) FILTER (WHERE sub_category IS NULL) AS missing_sub_category,
    COUNT(*) FILTER (WHERE unit_price IS NULL) AS missing_unit_price
FROM retail.products;

/*
10. Check sales with missing customer references
*/

SELECT
    s.customer_id
FROM retail.sales s
LEFT JOIN retail.customers c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

/*
11. Check sales with missing product references
*/

SELECT
    s.product_id
FROM retail.sales s
LEFT JOIN retail.products p
    ON s.product_id = p.product_id
WHERE p.product_id IS NULL;

/*
12. Validate profit calculation
*/

SELECT
    order_id,
    sales,
    cost,
    profit,
    ROUND(sales - cost, 2) AS calculated_profit
FROM retail.sales
WHERE ROUND(sales - cost, 2) <> ROUND(profit, 2);

/*
13. Check invalid quantities
*/

SELECT *
FROM retail.sales
WHERE quantity <= 0;

/*
14. Check invalid financial values
*/

SELECT *
FROM retail.sales
WHERE sales < 0
   OR cost < 0
   OR profit < 0;