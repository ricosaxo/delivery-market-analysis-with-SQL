--SQLite

-- Question: Map locations offering kapsalons and their average price.

-- Deliveroo

SELECT 
restaurants.postal_code, menu_items.name, AVG(menu_items.price) as average_kapsalon_price 
FROM restaurants
INNER JOIN menu_items
ON restaurants.id = menu_items.restaurant_id
WHERE menu_items.name = 'kapsalon' OR menu_items.name = 'Kapsalon' 
AND menu_items.price IS NOT NULL AND menu_items.price > 0
GROUP BY postal_code
ORDER BY average_kapsalon_price DESC

-- takeaway


-- Question: Which restaurants have the best price-to-rating ratio?

-- Deliveroo

SELECT 
    menu_items.restaurant_id, 
    restaurants.name, 
    ROUND(AVG(menu_items.price), 2) AS avg_price,
    restaurants.rating,
    CASE 
        WHEN AVG(menu_items.price) < 10 THEN 'Low'
        WHEN AVG(menu_items.price) BETWEEN 10 AND 20 THEN 'Medium'
        WHEN AVG(menu_items.price) BETWEEN 20 AND 30 THEN 'High'
        ELSE 'Premium'
    END AS price_bucket
FROM 
    menu_items
INNER JOIN 
    restaurants
ON 
    menu_items.restaurant_id = restaurants.id
WHERE 
    menu_items.price IS NOT NULL 
    AND menu_items.price <> 0
    AND menu_items.price > 0
    AND restaurants.rating IS NOT NULL
GROUP BY 
    menu_items.restaurant_id, restaurants.name, restaurants.rating
ORDER BY
    restaurants.rating DESC, avg_price ASC;



-- takeaway

SELECT
    menuItems.primarySlug,
    restaurants.name,
    ROUND(AVG(menuItems.price), 2) AS avg_price,
    restaurants.ratings,
    CASE 
        WHEN AVG(menuItems.price) < 10 THEN 'Low'
        WHEN AVG(menuItems.price) BETWEEN 10 AND 20 THEN 'Medium'
        WHEN AVG(menuItems.price) BETWEEN 20 AND 30 THEN 'High'
        ELSE 'Premium'
    END AS price_bucket
FROM
    menuItems
INNER JOIN
    restaurants
ON 
    menuItems.primarySlug = restaurants.primarySlug
WHERE
    menuItems.price IS NOT NULL 
    AND menuItems.price <> 0
    AND menuItems.pice > 0 
    AND restaurants.ratings IS NOT NULL
GROUP BY
    menuItems.primarySlug,
    restaurants.name,
    restaurants.ratings
ORDER BY
    restaurants.ratings DESC, avg_price ASC;


-- ubereats

DESCRIBE 
    menu_items;


SELECT
    menu_items.id,
    restaurants.name,
    ROUND(AVG(menu_items.

FROM
    menu_items
INNER JOIN
    restaurants
ON
    menu_items.id = restaurants.id


