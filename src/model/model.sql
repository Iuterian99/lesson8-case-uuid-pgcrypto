select 
restaurant_name as name,
COUNT (branch_id) AS count
FROM restaurants
LEFT JOIN branchs
ON
restaurant_id = branch_id
GROUP BY restaurant_name;

select * from restaurants where restaurant_name LIKE 'r%';

CREATE EXTENSION "uuid-ossp";

CREATE TABLE users(
  user_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_name varchar(50) NOT NULL
);


INSERT INTO users(user_name) values('Muslim');

CREATE TABLE posts(
  post_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  post_title varchar(100) NOT NULL,
  user_id uuid REFERENCES users(user_id)
);