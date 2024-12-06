SELECT title, sanitized_title slug,
       rating__rating_value AS rating,
       CAST(rating__review_count AS INTEGER) AS rating_number, id
FROM restaurants
WHERE CAST(rating__review_count AS INTEGER) > 100
ORDER BY rating__rating_value DESC;

SELECT location_city, COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY location__city 
ORDER BY restaurant_count DESC;
