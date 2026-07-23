/*
====================================================
PHASE 6 — TIME ANALYSIS
====================================================
*/
/*
1. Monthly Sales Performance
*/

SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
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
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

/*
2. Quarterly Sales Performance
*/

SELECT
    EXTRACT(
        QUARTER FROM order_date
    ) AS quarter,
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
GROUP BY EXTRACT(QUARTER FROM order_date)
ORDER BY quarter;

/*
3. Monthly Profit Performance
*/

SELECT
    TRIM(TO_CHAR(order_date, 'Month')) AS month_name,
    EXTRACT(MONTH FROM order_date) AS month_number,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM retail.sales
GROUP BY
    TO_CHAR(order_date, 'Month'),
    EXTRACT(MONTH FROM order_date)
ORDER BY total_profit DESC;

/*
4. Month-over-Month Sales Growth
*/

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        ROUND(SUM(sales), 2) AS total_sales
    FROM retail.sales
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales,

    ROUND(
        (
            total_sales
            - LAG(total_sales) OVER (
                ORDER BY month
            )
        )
        /
        NULLIF(
            LAG(total_sales) OVER (
                ORDER BY month
            ),
            0
        )
        * 100,
        2
    ) AS month_over_month_growth_percentage

FROM monthly_sales
ORDER BY month;