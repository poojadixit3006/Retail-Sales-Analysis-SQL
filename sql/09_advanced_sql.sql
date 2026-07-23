/*
====================================================
PHASE 9 — ADVANCED SQL
====================================================
*/

/*
1. Products with Above-Average Profit Margin
*/

WITH product_profitability AS (

    SELECT
        p.product_id,
        p.product_name,
        p.category,

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
)

SELECT
    product_id,
    product_name,
    category,
    total_sales,
    total_profit,
    profit_margin_percentage
FROM product_profitability
WHERE profit_margin_percentage >
      (
          SELECT AVG(profit_margin_percentage)
          FROM product_profitability
      )
ORDER BY profit_margin_percentage DESC;

/*
2. Rank Products by Total Sales
*/

WITH product_sales AS (

    SELECT
        p.product_id,
        p.product_name,
        p.category,

        ROUND(SUM(s.sales), 2) AS total_sales

    FROM retail.sales s

    INNER JOIN retail.products p
        ON s.product_id = p.product_id

    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)

SELECT
    product_id,
    product_name,
    category,
    total_sales,

    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank

FROM product_sales

ORDER BY sales_rank;

/*
3. Top 2 Products Within Each Category
*/

WITH product_sales AS (

    SELECT
        p.product_id,
        p.product_name,
        p.category,

        ROUND(SUM(s.sales), 2) AS total_sales

    FROM retail.sales s

    INNER JOIN retail.products p
        ON s.product_id = p.product_id

    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),

ranked_products AS (

    SELECT
        product_id,
        product_name,
        category,
        total_sales,

        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS category_rank

    FROM product_sales
)

SELECT
    product_id,
    product_name,
    category,
    total_sales,
    category_rank
FROM ranked_products
WHERE category_rank <= 2
ORDER BY
    category,
    category_rank;