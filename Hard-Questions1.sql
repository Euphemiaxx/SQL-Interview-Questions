
/* Airbnb - Given a table of rental property searches by users, 
            find the minimum, average, maximum rental prices for each host’s popularity rating */

WITH rating_agg AS(
            
    /* Third table: Obtaining price aggregates per popularity rating and
                    adding a column as basis of correct order of ratings in the output */
    SELECT
        host_pop_rating,
        min(price) min_price,
        avg(price) avg_price,
        max(price) max_price,
        CASE
            WHEN host_pop_rating = 'New' THEN 1
            WHEN host_pop_rating = 'Hot' THEN 2
            WHEN host_pop_rating = 'Rising' THEN 4
            WHEN host_pop_rating = 'Trending Up' THEN 5
            WHEN host_pop_rating = 'Popular' THEN 3
        END AS rating_order
    FROM
        (
            /* Second table: Giving popularity rating to hosts based on number of reviews  */
            SELECT
                hosts_id,
                price,
                number_of_reviews,
                CASE
                    WHEN number_of_reviews = 0 THEN 'New'
                    WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
                    WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
                    WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
                    ELSE 'Hot'
                END AS host_pop_rating
            FROM
                (
                    /* First table: Making the distinct list of hosts with their updated price and reviews */
                    SELECT
                        concat(price, room_type, host_since, zipcode, number_of_reviews) hosts_id,
                        max(price) price,
                        max(number_of_reviews) number_of_reviews
                    FROM
                        airbnb_host_searches
                    GROUP BY
                        concat(price, room_type, host_since, zipcode, number_of_reviews)
                ) AS hosts
        ) AS hosts_rating
    GROUP BY
        host_pop_rating
)

/* Final output: Price aggregates by popularity rating  */
SELECT
    host_pop_rating,
    min_price,
    avg_price,
    max_price
FROM
    rating_agg
ORDER BY
    rating_order ASC;
