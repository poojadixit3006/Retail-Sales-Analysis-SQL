/*
====================================================
PHASE 5 — PRODUCT ANALYSIS
====================================================
*/

/*
1. Top Products by Sales
*/

SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.sub_category,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.sales), 2) AS total_sales,
    ROUND(SUM(s.profit), 2) AS total_profit,
    ROUND(
        SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales s
INNER JOIN retail.products p
    ON s.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.sub_category
ORDER BY total_sales DESC
LIMIT 10;