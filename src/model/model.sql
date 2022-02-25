select 
restaurant_name as name,
COUNT (branch_id) AS count
FROM restaurants
LEFT JOIN branchs
ON
restaurant_id = branch_id
GROUP BY restaurant_name;

select * from restaurants where restaurant_name LIKE 'r%';

CREATE EXTENSION "uuid-ossp"; --! "uuid" idlarni hashlash(shriftlash) uchun ishlatiladi
CREATE EXTENSION IF NOT EXISTS "pgcrypto"; --! passwordlarni hashlash uchun ishlatiladi

CREATE TABLE users(
  user_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_name varchar(50) NOT NULL
);


INSERT INTO users(user_name) values('Muslim');
INSERT INTO users(user_name) values('Sardor');

CREATE TABLE posts(
  post_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  post_title varchar(100) NOT NULL,
  user_id uuid REFERENCES users(user_id)
);

INSERT INTO posts(post_title, user_id) values('Futbol barca- Napoli', '5cb777f3-b2d7-4dcf-b5d3-6c8acaf5af6f');

SELECT
  u.user_id,
  u.user_name,
  p.post_title
From users u 
LEFT JOIN 
  posts p 
USING(user_id); --! ON bilan bir xil vazifa bajaradi farqi reference nomi bilan asosiy table id si bir xil bo`sa USING ishlatish mumkin!

ALTER TABLE users ADD COLUMN user_password varchar(150);

  INSERT INTO users(user_name, user_password) VALUES('Nurulloh', crypt('parollik', gen_salt('bf', 4)));

SELECT * FROM users WHERE user_name = 'Nurulloh' AND user_password = crypt('parollik', user_password);