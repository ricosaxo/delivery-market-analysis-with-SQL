--SQLite
SELECT 
    restaurants.id, restaurants.address, restaurants.latitude, restaurants.longitude, restaurants.postal_code, menu_items.name, AVG(menu_items.price) 
FROM restaurants
INNER JOIN menu_items
ON restaurants.id = menu_items.restaurant_id
WHERE menu_items.name LIKE '%apsalon%' 
AND menu_items.price IS NOT NULL
GROUP BY postal_code


