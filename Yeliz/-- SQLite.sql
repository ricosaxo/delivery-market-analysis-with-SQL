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