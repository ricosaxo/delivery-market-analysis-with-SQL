-- SQLite


-- deliveroo database
UPDATE categories
SET name = LOWER(name);

SELECT name, COUNT (*) AS count FROM categories GROUP BY name ORDER BY name;

SELECT * FROM menu_items WHERE price > 1;

    -- I checked the menu_items table's data type
PRAGMA table_info(menu_items);


    -- creating a new column as price_float with the data type float 
ALTER TABLE menu_items
ADD COLUMN price_float FLOAT;

UPDATE menu_items
SET price_float = CAST(price AS FLOAT)
WHERE typeof(price) IN ('integer', 'real') OR price GLOB '[0-9]*';

PRAGMA table_info(menu_items);

SELECT * FROM menu_items;
--LIMIT 5;


    -- Grouping the price into specific ranges and count the total number of items for each range.
SELECT 
    CASE
        WHEN price_float BETWEEN 1.0 AND 10.0 THEN '1.0-10.0'
        WHEN price_float > 10.0 AND price_float <= 20.0 THEN '10.0-20.0'
        WHEN price_float > 20.0 AND price_float <= 30.0 THEN '20.0-30.0'
        WHEN price_float > 30.0 AND price_float <= 50.0 THEN '30.0-50.0'
        ELSE '50.0+'
    END AS price_range,
    COUNT(*) AS item_count
FROM menu_items
WHERE price_float > 1.0
GROUP BY price_range
ORDER BY price_range;


-- ubereats database

    -- making the price float
UPDATE menu_items
SET price = price / 100;

SELECT * FROM menu_items;

PRAGMA table_info(menu_items);

    -- creating a new column as price_float with the data type float 
ALTER TABLE menu_items
ADD COLUMN price_float FLOAT;

UPDATE menu_items
SET price_float = CAST(price AS FLOAT)
WHERE typeof(price) IN ('integer', 'real') OR price GLOB '[0-9]*';

PRAGMA table_info(menu_items);

   -- Grouping the price into specific ranges and count the total number of items for each range.
SELECT 
    CASE
        WHEN price_float BETWEEN 1.0 AND 10.0 THEN '1.0-10.0'
        WHEN price_float > 10.0 AND price_float <= 20.0 THEN '10.0-20.0'
        WHEN price_float > 20.0 AND price_float <= 30.0 THEN '20.0-30.0'
        WHEN price_float > 30.0 AND price_float <= 50.0 THEN '30.0-50.0'
        ELSE '50.0+'
    END AS price_range,
    COUNT(*) AS item_count
FROM menu_items
WHERE price_float > 1.0
GROUP BY price_range
ORDER BY price_range;


--- takeaway database

PRAGMA table_info(menuItems);

    -- creating a new column as price_float with the data type float 
ALTER TABLE menuItems
ADD COLUMN price_float FLOAT;

UPDATE menuItems
SET price_float = CAST(price AS FLOAT)
WHERE typeof(price) IN ('integer', 'real') OR price GLOB '[0-9]*';

PRAGMA table_info(menuItems);

   -- Grouping the price into specific ranges and count the total number of items for each range.
SELECT 
    CASE
        WHEN price_float BETWEEN 1.0 AND 10.0 THEN '1.0-10.0'
        WHEN price_float > 10.0 AND price_float <= 20.0 THEN '10.0-20.0'
        WHEN price_float > 20.0 AND price_float <= 30.0 THEN '20.0-30.0'
        WHEN price_float > 30.0 AND price_float <= 50.0 THEN '30.0-50.0'
        ELSE '50.0+'
    END AS price_range,
    COUNT(*) AS item_count
FROM menuItems
WHERE price_float > 1.0
GROUP BY price_range
ORDER BY price_range;



--- Identify the World Hummus Order (WHO); top 3 hummus serving restaurants

-- deliveroo database
UPDATE menu_items
SET name = LOWER(name);

SELECT * FROM menu_items;

SELECT 
    restaurants.name AS restaurant_name,  -- Selects the name of the restaurant and renames it as 'restaurant_name'
    AVG(restaurants.rating) AS avg_rating,            
    COUNT(menu_items.name) AS hummus_item_count -- Counts the number of menu items containing 'hummus' and renames it as 'hummus_item_count'
FROM 
    menu_items                            -- Refers directly to the 'menu_items' table
JOIN 
    restaurants                           -- Refers directly to the 'restaurants' table
ON 
    menu_items.restaurant_id = restaurants.id  -- Joins 'menu_items' with 'restaurants' using 'restaurant_id' in 'menu_items' and 'id' in 'restaurants'
WHERE 
    menu_items.name LIKE '%hummus%'       -- Filters menu items to include only those where the name contains 'hummus'
GROUP BY 
    restaurants.id, restaurants.name, restaurants.rating -- Groups the results by restaurant ID, name, and rating
ORDER BY 
    restaurants.rating DESC,             -- Orders the results by restaurant rating in descending order
    hummus_item_count DESC               -- For restaurants with the same rating, orders by the number of 'hummus' items in descending order
LIMIT 3;                                 -- Limits the results to the top 3 restaurants



--takeaway database
UPDATE menuItems
SET name = LOWER(name);

SELECT * FROM menuItems;

SELECT 
    restaurants.name AS restaurant_name,  
    AVG(restaurants.ratings) AS avg_rating,                   
    COUNT(menuItems.name) AS hummus_item_count 
FROM 
    menuItems                             
JOIN 
    restaurants                           
ON 
    menuItems.primarySlug = restaurants.primarySlug  
WHERE 
    menuItems.name LIKE '%hummus%'        
GROUP BY 
    restaurants.primarySlug, restaurants.name, restaurants.ratings 
ORDER BY 
    restaurants.ratings DESC,              
    hummus_item_count DESC                
LIMIT 3;                                  


-- ubereaats database

UPDATE menu_items
SET name = LOWER(name);

SELECT * FROM menu_items;

PRAGMA table_info(restaurants);

-- 1. Yeni bir FLOAT tipi kolon oluştur
ALTER TABLE restaurants
ADD COLUMN rating_float FLOAT;

-- 2. Mevcut rating__rating_rating değerlerini yeni kolona dönüştür ve taşı
UPDATE restaurants
SET rating_float = CAST(rating__rating_value AS FLOAT);


SELECT 
    restaurants.title AS restaurant_name, 
    AVG(restaurants.rating_float) AS avg_rating,                
    COUNT(menu_items.name) AS hummus_item_count 
FROM 
    menu_items                           
JOIN 
    restaurants                         
ON 
    menu_items.restaurant_id = restaurants.id  
WHERE 
    menu_items.name LIKE '%hummus%'     
GROUP BY 
    restaurants.id, restaurants.title, restaurants.rating_float
ORDER BY 
    restaurants.rating_float DESC,             
    hummus_item_count DESC               
LIMIT 3;                                 


-- Question: How does the availability of vegetarian and vegan dishes vary by area?

-- Deliveroo

SELECT
    restaurants.postal_code,
    COUNT(DISTINCT menu_items.name) AS halal_mitems
FROM
    restaurants
INNER JOIN 
    menu_items
ON 
    restaurants.id = menu_items.restaurant_id
WHERE
    (
        LOWER(menu_items.name) LIKE '%hala%' OR
        LOWER(menu_items.name) LIKE '%helal%'
    )
    AND restaurants.postal_code IS NOT NULL
GROUP BY
    restaurants.postal_code
ORDER BY
    halal_mitems DESC;


-- takeaway

SELECT
    locations.postalCode,
    COUNT(DISTINCT menuItems.name) AS halal_mitems
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
        LOWER(menuItems.name) LIKE '%hala%' OR
        LOWER(menuItems.name) LIKE '%helal%'
    )
    AND locations.postalCode IS NOT NULL
GROUP BY
    locations.postalCode
ORDER BY
    halal_mitems DESC;



-- Ubereats

SELECT 
    SUBSTR(restaurants.location__address, -4) AS postal_code, 
    COUNT(DISTINCT menu_items.name) AS halal_mitems
FROM 
    menu_items
INNER JOIN 
    restaurants 
ON 
    menu_items.restaurant_id = restaurants.id
WHERE 
   (
        LOWER(menu_items.name) LIKE '%hala%' OR
        LOWER(menu_items.name) LIKE '%helal%'
    )
    AND SUBSTR(restaurants.location__address, -4) IS NOT NULL
GROUP BY 
    SUBSTR(restaurants.location__address, -4)
ORDER BY 
    halal_mitems DESC;



-- Yeni
SELECT DISTINCT restaurants.id, restaurants.latitude, restaurants.longitude, restaurants.postal_code
FROM restaurants
JOIN menu_items ON restaurants.id = menu_items .restaurant_id
WHERE LOWER(menu_items.name) LIKE '%halal%';

PRAGMA table_info(menu_items);