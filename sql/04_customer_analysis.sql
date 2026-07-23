/*
====================================================
PHASE 4 — CUSTOMER ANALYSIS
====================================================
*/

/*
1. Top Customers by Sales
*/

SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.quantity) AS total_quantity_purchased,
    ROUND(SUM(s.sales), 2) AS total_sales,
    ROUND(SUM(s.profit), 2) AS total_profit
FROM retail.sales s
INNER JOIN retail.customers c
    ON s.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.segment
ORDER BY total_sales DESC
LIMIT 10;