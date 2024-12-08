--Deliveroo
SELECT
	COUNT(restaurants.id) AS number_of_resturants,
	restaurants.postal_code
FROM
	restaurants
WHERE
	restaurants.postal_code <> ''
GROUP BY
	restaurants.postal_code
ORDER BY
	number_of_resturants DESC;
---------------------------------------
--take_away
SELECT 
    COUNT(inner_query.number_restaurants) AS number_of_resturants,
    inner_query.postal_code
FROM (
    SELECT 
        COUNT(DISTINCT tw.restaurants."primarySlug") AS number_restaurants,
        tw.locations.postalCode AS postal_code,
        tw.restaurants.name
    FROM 
        tw.restaurants
    INNER JOIN
        tw.locations_to_restaurants
    ON
        tw.restaurants.primarySlug = tw.locations_to_restaurants.restaurant_id
    INNER JOIN
        tw.locations
    ON
        tw.locations_to_restaurants.location_id = tw.locations.ID
    WHERE
        tw.locations.postalCode IS NOT NULL
    GROUP BY 
        tw.restaurants.name, tw.restaurants.address
) AS inner_query
GROUP BY 
    inner_query.postal_code
ORDER BY 
    number_of_resturants DESC;
-----------------------------------------------------------
--ubereats
SELECT
                    COUNT(DISTINCT ue.restaurants.id) AS number_of_restaurants,
                    SUBSTR(ue.restaurants.location__address, -4) AS postal_code
            FROM
                ue.restaurants
            WHERE
                LENGTH(SUBSTR(ue.restaurants.location__address, -4)) = 4
                AND SUBSTR(ue.restaurants.location__address, -4) GLOB '[0-9][0-9][0-9][0-9]'
            GROUP BY
                postal_code
            ORDER BY
                number_of_restaurants DESC;
