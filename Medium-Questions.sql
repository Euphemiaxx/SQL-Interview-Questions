/* Amazon , Shopify - Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
                      If customer had more than one order on a certain day, sum the order costs on daily basis. 
                      Output customer's first name, total cost of their items, and the date. */
SELECT
    top 1 first_name,
    sum(total_order_cost) total_order_cost,
    order_date
FROM
    customers
JOIN orders ON
    orders.cust_id = customers.id
GROUP BY
    first_name,
    order_date
ORDER BY
    total_order_cost DESC;


/* Walmart , Best Buy, Dropbox -  Find the employees that earn more than their manager */ 
SELECT 
    first_name employee_name,
    salary employee_salary
FROM
    employee a
WHERE
    salary > (
        SELECT
            salary
        FROM
            employee b
        WHERE
            a.manager_id = b.id);
            
            
/* Salesforce -  Find the employees who achieved highest target under a specific manager */            
DECLARE @specific_manager AS int = 13

SELECT
    first_name,
    target
FROM
    salesforce_employees
WHERE
    manager_id = @specific_manager
    AND target = (
        SELECT
            max(target)
        FROM
            salesforce_employees
        WHERE
            manager_id = @specific_manager);
            
            
/* Yelp -  Find the top businesses with most reviews */ 
SELECT 
    top 5 name,
    max(review_count) reviews
FROM 
    yelp_business
GROUP BY 
    name
ORDER BY 
    reviews DESC;
 
 
/* Forbes - Find the 3 most profitable companies */ 
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


/* ESPN -  Find the Olympics with the highest number of athletes  */ 
SELECT
    top 1 games,
    count(DISTINCT(name)) athletes_count
FROM
    olympics_athletes_events
GROUP BY
    games
ORDER BY
    athletes_count DESC ;
    
/* Spotify -  Find the top ranked songs and frequency of being top ranked  */    
SELECT 
    trackname,
    count(trackname) times_top1
FROM 
    spotify_worldwide_daily_song_ranking
WHERE
    POSITION = 1
GROUP BY
    trackname
ORDER BY
    times_top1 DESC,
    trackname;


/* Leetcode 176: Find second highest salary, must return null if there's no output */ 
SELECT
    isnull(
        (SELECT
                 DISTINCT(salary) SecondHighestSalary
            FROM
                (
                    SELECT
                        salary,
                        DENSE_RANK() OVER (
                        ORDER BY
                            salary DESC
                        ) ranks
                    FROM
                        employee
                ) a
            WHERE
                ranks = 2),
        NULL
    ) SecondHighestSalary;
 
    
