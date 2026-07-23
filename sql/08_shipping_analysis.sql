/*
====================================================
PHASE 8 — SHIPPING ANALYSIS
====================================================
*/

/*
1. Average Shipping Duration
*/

SELECT
    ROUND(
        AVG(ship_date - order_date),
        2
    ) AS average_shipping_days,

    MIN(ship_date - order_date) AS fastest_shipping_days,

    MAX(ship_date - order_date) AS longest_shipping_days
FROM retail.sales;

/*
2. Fast vs Delayed Shipments
*/

SELECT
    CASE
        WHEN ship_date - order_date BETWEEN 1 AND 3
            THEN 'Fast'
        WHEN ship_date - order_date BETWEEN 4 AND 5
            THEN 'Standard'
        WHEN ship_date - order_date BETWEEN 6 AND 7
            THEN 'Delayed'
    END AS shipping_status,

    COUNT(*) AS total_orders,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_orders,

    ROUND(AVG(ship_date - order_date), 2)
        AS average_shipping_days

FROM retail.sales

GROUP BY
    CASE
        WHEN ship_date - order_date BETWEEN 1 AND 3
            THEN 'Fast'
        WHEN ship_date - order_date BETWEEN 4 AND 5
            THEN 'Standard'
        WHEN ship_date - order_date BETWEEN 6 AND 7
            THEN 'Delayed'
    END

ORDER BY
    average_shipping_days;

/*
3. Shipping Performance by Region
*/

SELECT
    region,

    COUNT(*) AS total_orders,

    ROUND(
        AVG(ship_date - order_date),
        2
    ) AS average_shipping_days,

    MIN(ship_date - order_date)
        AS fastest_shipping_days,

    MAX(ship_date - order_date)
        AS longest_shipping_days,

    COUNT(*) FILTER (
        WHERE ship_date - order_date >= 6
    ) AS delayed_orders,

    ROUND(
        COUNT(*) FILTER (
            WHERE ship_date - order_date >= 6
        ) * 100.0 / COUNT(*),
        2
    ) AS delayed_order_percentage

FROM retail.sales

GROUP BY region

ORDER BY average_shipping_days;