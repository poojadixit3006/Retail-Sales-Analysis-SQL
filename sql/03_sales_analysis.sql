/*
====================================================
PHASE 3 — SALES ANALYSIS
====================================================
*/

/*
1. Sales Performance by Region
*/

SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales
GROUP BY region
ORDER BY total_sales DESC;

/*
2. Sales Performance by State
*/

SELECT
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales
GROUP BY state
ORDER BY total_sales DESC;

/*
3. Sales Performance by City
*/

SELECT
    city,
    state,
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales
GROUP BY
    city,
    state,
    region
ORDER BY total_sales DESC;

/*
4. Sales Performance by Category
*/

SELECT
    p.category,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.sales), 2) AS total_sales,
    ROUND(SUM(s.cost), 2) AS total_cost,
    ROUND(SUM(s.profit), 2) AS total_profit,
    ROUND(
        SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales s
INNER JOIN retail.products p
    ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

/*
5. Sales Performance by Sub-Category
*/

SELECT
    p.category,
    p.sub_category,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.sales), 2) AS total_sales,
    ROUND(SUM(s.cost), 2) AS total_cost,
    ROUND(SUM(s.profit), 2) AS total_profit,
    ROUND(
        SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales s
INNER JOIN retail.products p
    ON s.product_id = p.product_id
GROUP BY
    p.category,
    p.sub_category
ORDER BY total_sales DESC;

/*
6. Sales Performance by Payment Mode
*/

SELECT
    payment_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales
GROUP BY payment_mode
ORDER BY total_sales DESC;
