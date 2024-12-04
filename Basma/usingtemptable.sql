-- SQLite
--What is the distribution of restaurants per location?
--for Delivero db
CREATE TEMP TABLE EditedRestaurants AS
SELECT 
    restaurants.ID AS restaurant_id, 
    CASE 
         WHEN postal_code glob '[0-9][0-9][0-9][0-9]*[^0-9]*' THEN substr(postal_code, 1, 4)
        ELSE postal_code
    END AS new_postal_code
FROM restaurants
WHERE restaurants.postal_code IS NOT NULL;

SELECT 
    COUNT(EditedRestaurants.restaurant_id) AS No_of_Restaurants, 
    EditedRestaurants.new_postal_code
FROM EditedRestaurants

GROUP BY EditedRestaurants.new_postal_code
ORDER BY No_of_Restaurants DESC;
drop table EditedRestaurants