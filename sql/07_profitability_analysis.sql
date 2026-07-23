/*
====================================================
PHASE 7 — PROFITABILITY ANALYSIS
====================================================
*/

/*
1. Profitable vs Loss-Making Orders
*/

SELECT
    CASE
        WHEN profit > 0 THEN 'Profitable'
        WHEN profit < 0 THEN 'Loss-Making'
        ELSE 'Break-Even'
    END AS order_status,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM retail.sales
GROUP BY
    CASE
        WHEN profit > 0 THEN 'Profitable'
        WHEN profit < 0 THEN 'Loss-Making'
        ELSE 'Break-Even'
    END
ORDER BY total_orders DESC;

/*
2. Loss-Making Orders by Product
*/

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(*) AS loss_making_orders,
    ROUND(SUM(s.sales), 2) AS total_sales,
    ROUND(SUM(s.cost), 2) AS total_cost,
    ROUND(SUM(s.profit), 2) AS total_loss
FROM retail.sales s
INNER JOIN retail.products p
    ON s.product_id = p.product_id
WHERE s.profit < 0
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_loss ASC;


/*
3. Discount Analysis
*/

SELECT
    discount_percentage,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales
GROUP BY discount_percentage
ORDER BY discount_percentage;


/*
4. High-Sales but Low-Profit Products
*/

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(DISTINCT s.order_id) AS total_orders,
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
    p.category
HAVING
    SUM(s.sales) > 10000000
    AND
    SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100 < 15
ORDER BY total_sales DESC;