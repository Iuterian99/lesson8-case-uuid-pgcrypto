select 
restaurant_name as name,
COUNT (branch_id) AS count
FROM restaurants
LEFT JOIN branchs
ON
restaurant_id = branch_id
GROUP BY restaurant_name;

select * from restaurants where restaurant_name LIKE 'r%';