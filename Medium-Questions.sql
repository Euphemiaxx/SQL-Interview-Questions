/* FORBES - Find the top 3 most profitable Companies */ 
SELECT
    TOP 3 company,
    profits profit
FROM
    forbes_global_2010_2014
ORDER BY
    profits DESC;


/* Amazon , DoorDash -  Find the job titles of the highest-paid employees */ 
SELECT
    worker_title best_paid_title
FROM
    worker
INNER JOIN title ON
    (worker.worker_id = worker_ref_id)
WHERE
    salary = (
        SELECT
            max(salary)
        FROM
            worker)
ORDER BY
    best_paid_title;


/* Meta/Facebook, Amazon -  Find the revenue per active customer in March 2019  */ 
SELECT
    cust_id,
    sum(total_order_cost) revenue
FROM
    orders
WHERE
    MONTH(order_date) = 03
    AND YEAR(order_date) = 2019
GROUP BY
    cust_id
ORDER BY
    revenue DESC;
