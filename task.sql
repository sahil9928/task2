WITH MonthlySpending AS (
    SELECT
        c.customer_id,
        c.name,
        EXTRACT(YEAR FROM s.sale_date) AS year,
        EXTRACT(MONTH FROM s.sale_date) AS month,
        SUM(s.amount) AS total_spent
    FROM
        sales s
    JOIN
        customers c ON s.customer_id = c.customer_id
    WHERE
        s.sale_date >= CURRENT_DATE - INTERVAL '12 MONTH'
    GROUP BY
        c.customer_id, c.name, EXTRACT(YEAR FROM s.sale_date), EXTRACT(MONTH FROM s.sale_date)
),
SpendingGrowth AS (
    SELECT
        customer_id,
        name,
        year,
        month,
        total_spent,
        LAG(total_spent) OVER (PARTITION BY customer_id ORDER BY year, month) AS previous_month_spent,
        total_spent - LAG(total_spent) OVER (PARTITION BY customer_id ORDER BY year, month) AS month_to_month_growth
    FROM
        MonthlySpending
)
SELECT
    customer_id,
    name,
    year,
    month,
    total_spent,
    month_to_month_growth,
    CASE
        WHEN month_to_month_growth > 0 THEN 'Growth'
        WHEN month_to_month_growth < 0 THEN 'Decline'
        ELSE 'No Change'
    END AS spending_trend
FROM
    SpendingGrowth
ORDER BY
    customer_id, year DESC, month DESC;



SELECT
    p.product_name,
    p.category,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT
        pr.product_name,
        pr.category,
        SUM(s.amount) AS total_sales
    FROM
        sales s
    JOIN
        products pr ON s.product_id = pr.product_id
    GROUP BY
        pr.product_name, pr.category
) AS ProductSales
ORDER BY
    sales_rank;



WITH MonthlySales AS (
    SELECT
        EXTRACT(YEAR FROM s.sale_date) AS year,
        EXTRACT(MONTH FROM s.sale_date) AS month,
        pr.product_name,
        SUM(s.amount) AS total_sales
    FROM
        sales s
    JOIN
        products pr ON s.product_id = pr.product_id
    GROUP BY
        year, month, pr.product_name
),
SalesGrowth AS (
    SELECT
        year,
        month,
        product_name,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY product_name ORDER BY year, month) AS previous_month_sales,
        total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY year, month) AS month_to_month_growth
    FROM
        MonthlySales
)
SELECT
    year,
    month,
    product_name,
    total_sales,
    month_to_month_growth,
    CASE
        WHEN month_to_month_growth > 0 THEN 'Growth'
        WHEN month_to_month_growth < 0 THEN 'Decline'
        ELSE 'No Change'
    END AS sales_trend
FROM
    SalesGrowth
ORDER BY
    year DESC, month DESC, total_sales DESC;
