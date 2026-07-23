/*
====================================================
Retail Sales SQL Analysis
File: 02_overall_business_performance.sql
Purpose: Overall Business Performance Analysis
====================================================
*/

/*
1. Overall Business Performance
*/

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(SUM(profit), 2) AS total_profit,

    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage,

    ROUND(
        SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value,

    ROUND(
        SUM(quantity)::NUMERIC
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_units_per_order

FROM retail.sales;