# task2
COMPANY:CODTECH IT SOLUTIONS
NAME:SAHIL ROMHARSHAN KALE
INTERN ID:CT08PNP
DOMAIN:SQL
DURATION:JANUARY 25TH,2025 TO FEBRUARY 25TH,2025.
MENTOR:NEELA SANTHOSH KUMAR

DESCRIPTION:The SQL queries provided above leverage Common Table Expressions (CTEs), window functions, and subqueries to conduct in-depth data analysis on sales and customer behavior. The goal is to generate a detailed report that highlights various trends and patterns, such as customer spending trends, top-performing products, and sales growth by product and customer.

1. Customer Spending Trends (Past 12 Months)
This query analyzes how much each customer has spent over the past 12 months and calculates the month-over-month growth in their spending.

CTE (MonthlySpending): This part of the query aggregates the total spending for each customer per month for the last 12 months.

It extracts the year and month from the sale_date column.
It sums the amount spent by each customer per month.
Window function (LAG()): This function compares the current month's spending with the previous month's spending for each customer.

The LAG() function is used to get the previous month's total spending for each customer within the same partition (customer).
The difference between the current and previous month's spending is calculated to show the month-to-month growth.
Result: This analysis provides insights into whether each customer is spending more, less, or the same compared to the previous month. The query also labels the spending trend as Growth, Decline, or No Change.

2. Top-Performing Products by Total Sales
This query identifies the best-selling products based on total sales revenue.

Subquery (ProductSales): The subquery calculates the total sales for each product.

It joins the sales and products tables to group sales by product and sum the amount spent on each product.
Window function (RANK()): The RANK() function is used to assign a rank to each product based on its total sales in descending order.

This allows us to easily see the top-performing products based on total sales.
Result: The output of this query ranks products by their total sales, providing insights into which products are performing the best in terms of sales revenue.

3. Month-over-Month Sales Growth for All Products
This query tracks the sales growth for each product on a monthly basis, helping us understand how sales are changing for each product from month to month.

CTE (MonthlySales): This CTE aggregates sales data for each product by month.

It sums the amount spent on each product per month and groups the data by product and the year/month extracted from the sale_date.
Window function (LAG()): Similar to the previous query, the LAG() function calculates the previous month's sales for each product.

The difference between the current month's total sales and the previous month's sales is calculated to show the month-to-month growth.
Result: This analysis helps identify the sales trends for each product, categorizing the growth as Growth, Decline, or No Change.

