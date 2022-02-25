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


--! Functions in  PLPGSQL 


--!----------------------------- CALCULATOR ---------------------------------------------------
CREATE OR REPLACE FUNCTION calc(num1 float, num2 float, sign_of text) 
RETURNS float 
LANGUAGE plpgsql
AS $$

DECLARE result float;

BEGIN 
IF 
    (sign_of = '+')
THEN 
    result = num1 + num2;
ELSIF 
    (sign_of = '-')
THEN 
    result = num1 - num2;
ELSIF 
    (sign_of = '*')
THEN 
    result = num1 * num2;
ELSIF 
    (sign_of = '/')
THEN 
    result = num1 / num2;
END IF;

RETURN result;

END;
$$;


select calc(5, 3, '/');

--!------------------------------------------- FIZZBUZZ ---------------------------------------------

CREATE OR REPLACE FUNCTION fizzbuzz(input int) 
RETURNS text
LANGUAGE plpgsql
AS $$

DECLARE result text;

BEGIN 
IF 
    (input % 3 = 0 AND input % 5 = 0)
THEN 
    result = 'FIZZBUZZ';
ELSIF 
    (input % 3 = 0)
THEN 
    result = 'FIZZ';
ELSIF 
    (input % 5 = 0)
THEN 
    result = 'BUZZ';
ELSIF 
    (input % 5 != 0 AND input % 3 != 0)
THEN 
    result = 'It is not divisible by 3 and 5';
END IF;

RETURN result;

END;
$$;


