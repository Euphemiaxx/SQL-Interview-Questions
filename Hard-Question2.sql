
/* Amazon - Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
            The output should include the year-month date (YYYY-MM) and percentage change, 
            rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year. */


/* Creating a CTE for the total revenue per month */  
WITH revenue_by_date AS (
    SELECT
        format(
            created_at,
            'yyyy-mm'
        ) year_month ,
        sum(value) revenue
    FROM
        sf_transactions
    GROUP BY
        LEFT(created_at, 7))

/* Using the above CTE to calculate % change in revenue 
where % change in revenue  = ((current month's revenue - last month's revenue) / last month's revenue) *100 */   
SELECT
    year_month,
    round((CAST (revenue - LAG(revenue, 1) OVER (ORDER BY year_month) AS float) / LAG(revenue, 1) OVER (ORDER BY year_month))* 100, 2) revenue_diff_pct
FROM
    revenue_by_date;
    
