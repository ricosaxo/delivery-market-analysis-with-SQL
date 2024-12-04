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
    COUNT(DISTINCT restaurants.primarySlug) AS number_of_resturants,
    locations.postalCode as postal_code
FROM
    restaurants
    JOIN locations_to_restaurants ON restaurants.primarySlug = locations_to_restaurants.restaurant_id
    JOIN locations ON locations_to_restaurants.location_id = locations."ID"
GROUP BY
    locations.postalCode
ORDER BY
    number_of_resturants DESC;
-----------------------------------------------------------
--ubereats
SELECT
	count(DISTINCT restaurants.id) AS number_of_resturants , locations.region AS postal_code
FROM
	restaurants
	JOIN locations_to_restaurants ON restaurants.id = locations_to_restaurants.restaurant_id
	JOIN locations ON locations_to_restaurants.location_id = locations.id
GROUP BY
	locations.region
Order by number_of_resturants DESC

update restaurants
set postal_code =

select * from restaurants where postal_code like '%L%'
update restaurants
set postal_code ='3000'
where postal_code = '3000LEUVEN'