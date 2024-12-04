SELECT name, 
       ratings AS rating, 
       CAST(ratingsNumber AS INTEGER) AS rating_number
FROM restaurants
WHERE CAST(ratingsNumber AS INTEGER) > 100
ORDER BY rating_number DESC;
