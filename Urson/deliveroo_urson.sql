SELECT category, name, rating, CAST(rating_number AS INTEGER) as rating_number
FROM restaurants
WHERE category = 'Pizza' AND CAST(rating_number AS INTEGER) > 100
ORDER BY rating DESC

