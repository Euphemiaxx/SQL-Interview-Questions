
/* Yelp - Find the top 5 states with the most 5 star businesses */

/* Creating a CTE to count all the businesses with 5 stars in each state and 
   ranking them by the count all the businesses with 5 stars */ 
WITH businesses_per_state AS (
    SELECT
        state,
        count(*) n_businesses,
        RANK() OVER (
        ORDER BY
            count(*) DESC
        ) rank
    FROM
        yelp_business
    WHERE
        stars = 5
    GROUP BY
        state
)

/* Retrieving all the state that has atleast rank 5, with their respective count of businesses with 5 stars */ 
SELECT
    state,
    n_businesses
FROM
    businesses_per_state
WHERE
    rank <= 5
ORDER BY
    n_businesses DESC,
    state;
