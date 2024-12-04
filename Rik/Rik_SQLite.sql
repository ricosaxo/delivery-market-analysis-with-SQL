--SQLite

-- Question: Map locations offering kapsalons and their average price.

-- Deliveroo

SELECT 
    restaurants.postal_code, 
    menu_items.name, 
    ROUND(AVG(menu_items.price),2) AS average_kapsalon_price 
FROM 
    restaurants
INNER JOIN 
    menu_items
ON 
    restaurants.id = menu_items.restaurant_id
WHERE 
    menu_items.name = 'Kapsalon' 
    AND menu_items.price IS NOT NULL 
    AND menu_items.price > 0
GROUP BY 
    restaurants.postal_code, menu_items.name
ORDER BY 
    average_kapsalon_price DESC;

-- takeaway

SELECT
    locations.postalCode,
    menuItems.name,
    ROUND(AVG(menuItems.price),2) AS average_kapsalon_price
FROM
    restaurants
INNER JOIN
    menuItems
ON
    restaurants.primarySlug = menuItems.primarySlug
INNER JOIN
    locations_to_restaurants
ON
    restaurants.primarySlug = locations_to_restaurants.restaurant_id
INNER JOIN
    locations
ON
    locations_to_restaurants.location_id = locations.ID
WHERE
    menuItems.name = 'Kapsalon'
    AND menuItems.price > 0
    AND menuItems.price IS NOT NULL
    AND locations.postalCode IS NOT NULL
GROUP BY
    locations.postalCode, menuItems.name
ORDER BY
    average_kapsalon_price DESC;

-- Ubereats

SELECT 
    SUBSTR(restaurants.location__address, -4) AS postal_code, 
    menu_items.name, 
    CAST(ROUND(AVG(menu_items.price) / 100, 2) AS FLOAT) AS average_kapsalon_price
FROM 
    menu_items
INNER JOIN 
    restaurants 
ON 
    menu_items.restaurant_id = restaurants.id
WHERE 
    CAST(menu_items.price AS FLOAT) > 0 
    AND menu_items.price IS NOT NULL
    AND menu_items.name = 'Kapsalon'
    AND SUBSTR(restaurants.location__address, -4) IS NOT NULL
GROUP BY 
    SUBSTR(restaurants.location__address, -4), menu_items.name
ORDER BY 
    average_kapsalon_price DESC;


-- Question: Which restaurants have the best price-to-rating ratio?

-- Deliveroo

SELECT 
    menu_items.restaurant_id, 
    restaurants.name, 
    ROUND(AVG(menu_items.price), 2) AS avg_price,
    restaurants.rating,
    ROUND(AVG(menu_items.price) / restaurants.rating, 2) AS price_to_rating_ratio,
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
    AND menu_items.price > 0
    AND restaurants.rating IS NOT NULL
    AND restaurants.rating > 0
GROUP BY 
    menu_items.restaurant_id, restaurants.name, restaurants.rating
HAVING
    price_bucket != 'Low'
ORDER BY
    price_to_rating_ratio ASC; 

-- takeaway

SELECT
    menuItems.primarySlug,
    restaurants.name,
    ROUND(AVG(menuItems.price), 2) AS avg_price,
    restaurants.ratings,
    ROUND(AVG(menuItems.price) / restaurants.ratings, 2) AS price_to_rating_ratio,
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
    AND menuItems.price > 0 
    AND restaurants.ratings IS NOT NULL
    AND restaurants.ratings > 0
GROUP BY
    menuItems.primarySlug,
    restaurants.name,
    restaurants.ratings
HAVING
    price_bucket != 'Low'  
ORDER BY
    price_to_rating_ratio ASC;


-- ubereats

SELECT
    menu_items.restaurant_id,
    restaurants.title,
    CAST(ROUND(AVG(menu_items.price) / 100, 2) AS FLOAT) AS avg_price,
    restaurants.rating__rating_value,
    CAST(ROUND(AVG(menu_items.price) / 100 / restaurants.rating__rating_value, 2) AS FLOAT) AS price_to_rating_ratio,
    CASE 
        WHEN AVG(menu_items.price) / 100 < 10 THEN 'Low'
        WHEN AVG(menu_items.price) / 100 BETWEEN 10 AND 20 THEN 'Medium'
        WHEN AVG(menu_items.price) / 100 BETWEEN 20 AND 30 THEN 'High'
        ELSE 'Premium'
    END AS price_bucket
FROM
    menu_items
INNER JOIN
    restaurants 
ON 
    menu_items.restaurant_id = restaurants.id
WHERE
    CAST(menu_items.price AS FLOAT) > 0
    AND menu_items.price IS NOT NULL
    AND restaurants.rating__rating_value IS NOT NULL
GROUP BY
    menu_items.restaurant_id, restaurants.title, restaurants.rating__rating_value
HAVING
    price_bucket != 'Low'
ORDER BY
    price_to_rating_ratio ASC;


-- Question: Where are the delivery ‘dead zones’—areas with minimal restaurant coverage?

-- Deliveroo

SELECT
    COUNT(DISTINCT restaurants.name) as total_restaurants,
    restaurants.postal_code
fROM
    restaurants
GROUP BY
    restaurants.postal_code
ORDER BY
    COUNT(DISTINCT restaurants.name)

-- takeaway

SELECT
    COUNT(DISTINCT restaurants.name) as total_restaurants,
    locations.postalCode
FROM
    restaurants
INNER JOIN
    locations_to_restaurants
ON
    restaurants.primarySlug = locations_to_restaurants.restaurant_id
INNER JOIN
    locations
ON
    locations_to_restaurants.location_id = locations.ID
WHERE
    locations.postalCode IS NOT NULL
GROUP BY
    locations.postalCode
ORDER BY
    COUNT(DISTINCT restaurants.name) ASC;

-- ubereats

SELECT
    COUNT(DISTINCT restaurants.title),
    SUBSTR(restaurants.location__address, -4) AS postal_code
FROM
    restaurants
WHERE
    SUBSTR(restaurants.location__address, -4) != '0 , '
    AND SUBSTR(restaurants.location__address, -4) !='00, '
    AND SUBSTR(restaurants.location__address, -4) !='000 '
    AND SUBSTR(restaurants.location__address, -4) !='02, '
    AND SUBSTR(restaurants.location__address, -4) !='en, '
    AND SUBSTR(restaurants.location__address, -4) !='lt, '
    AND SUBSTR(restaurants.location__address, -4) !='rp, '
GROUP BY
    SUBSTR(restaurants.location__address, -4)
ORDER BY
    COUNT(DISTINCT restaurants.title) ASC;

-- Question: How does the availability of vegetarian and vegan dishes vary by area?

-- Deliveroo

SELECT
    restaurants.postal_code,
    COUNT(DISTINCT menu_items.name) AS number_of_veggie_dishes
    
FROM
    restaurants
INNER JOIN 
    menu_items
ON 
    restaurants.id = menu_items.restaurant_id
WHERE
    (
        LOWER(menu_items.name) LIKE '%vegan%' OR
        LOWER(menu_items.name) LIKE '%vegetarisch%' OR
        LOWER(menu_items.name) LIKE '%veggie%' OR
        LOWER(menu_items.name) LIKE '%plantbased%'OR
        LOWER(menu_items.name) LIKE '%vegetarian%'
    )
    AND NOT (
        LOWER(menu_items.name) LIKE '%non vegan%' OR
        LOWER(menu_items.name) LIKE '%non veggie%' OR
        LOWER(menu_items.name) LIKE '%non vegetarian%'OR
        LOWER(menu_items.name) LIKE '%niet vegetarisch%' OR
        LOWER(menu_items.name) LIKE '%niet vegan%' OR
        LOWER(menu_items.name) LIKE '%niet veggie%' OR
        LOWER(menu_items.name) LIKE '%zonder plantaardig%'OR
        LOWER(menu_items.name) LIKE '%not vegan%' OR
        LOWER(menu_items.name) LIKE '%not veggie%'OR
        LOWER(menu_items.name) LIKE '%not vegetarian%'
    )
    AND restaurants.postal_code IS NOT NULL
GROUP BY
    restaurants.postal_code
ORDER BY
    number_of_veggie_dishes DESC;


-- takeaway

SELECT
    locations.postalCode,
    COUNT(DISTINCT menuItems.name) AS number_of_veggie_dishes
FROM
    restaurants
INNER JOIN
    menuItems
ON
    restaurants.primarySlug = menuItems.primarySlug
INNER JOIN
    locations_to_restaurants
ON
    restaurants.primarySlug = locations_to_restaurants.restaurant_id
INNER JOIN
    locations
ON
    locations_to_restaurants.location_id = locations.ID
WHERE
    (
        LOWER(menuItems.name) LIKE '%vegan%' OR
        LOWER(menuItems.name) LIKE '%vegetarisch%' OR
        LOWER(menuItems.name) LIKE '%veggie%' OR
        LOWER(menuItems.name) LIKE '%plantbased%' OR
        LOWER(menuItems.name) LIKE '%vegetarian%'
    )
    AND NOT (
        LOWER(menuItems.name) LIKE '%non vegan%' OR
        LOWER(menuItems.name) LIKE '%non veggie%' OR
        LOWER(menuItems.name) LIKE '%non vegetarian%' OR
        LOWER(menuItems.name) LIKE '%niet vegetarisch%' OR
        LOWER(menuItems.name) LIKE '%niet vegan%' OR
        LOWER(menuItems.name) LIKE '%niet veggie%' OR
        LOWER(menuItems.name) LIKE '%zonder plantaardig%' OR
        LOWER(menuItems.name) LIKE '%not vegan%' OR
        LOWER(menuItems.name) LIKE '%not veggie%' OR
        LOWER(menuItems.name) LIKE '%not vegetarian%'
    )
    AND locations.postalCode IS NOT NULL
GROUP BY
    locations.postalCode
ORDER BY
    number_of_veggie_dishes DESC;

-- Ubereats

SELECT 
    SUBSTR(restaurants.location__address, -4) AS postal_code, 
    COUNT(DISTINCT menu_items.name) AS number_of_veggie_dishes
FROM 
    menu_items
INNER JOIN 
    restaurants 
ON 
    menu_items.restaurant_id = restaurants.id
WHERE 
    (
        LOWER(menu_items.name) LIKE '%vegan%' OR
        LOWER(menu_items.name) LIKE '%vegetarisch%' OR
        LOWER(menu_items.name) LIKE '%veggie%' OR
        LOWER(menu_items.name) LIKE '%plantbased%'OR
        LOWER(menu_items.name) LIKE '%vegetarian%'
    )
    AND NOT (
        LOWER(menu_items.name) LIKE '%non vegan%' OR
        LOWER(menu_items.name) LIKE '%non veggie%' OR
        LOWER(menu_items.name) LIKE '%non vegetarian%'OR
        LOWER(menu_items.name) LIKE '%niet vegetarisch%' OR
        LOWER(menu_items.name) LIKE '%niet vegan%' OR
        LOWER(menu_items.name) LIKE '%niet veggie%' OR
        LOWER(menu_items.name) LIKE '%zonder plantaardig%'OR
        LOWER(menu_items.name) LIKE '%not vegan%' OR
        LOWER(menu_items.name) LIKE '%not veggie%'OR
        LOWER(menu_items.name) LIKE '%not vegetarian%'
    )
    AND SUBSTR(restaurants.location__address, -4) IS NOT NULL
GROUP BY 
    SUBSTR(restaurants.location__address, -4)
ORDER BY 
    number_of_veggie_dishes DESC;
