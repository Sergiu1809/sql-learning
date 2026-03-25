-- Creating tables

CREATE TABLE users (
    id SERIAL PRIMARY KEY, -- auto-incrementing number, unique identifier
    name VARCHAR(100) NOT NULL, -- text up to 100 characters & required, can't be null
    email VARCHAR(100) UNIQUE NOT NULL, -- no two users can have the same email
    age INTEGER, -- whole number, optional
    city VARCHAR(50) -- optional
);

-- INSERT

-- don't insert id - it's automatic.

INSERT INTO users (name, email, age, city)
VALUES ('Sergiu', 'sergiu@gmail.com', 20,'Sibiu');

INSERT INTO users (name, email, age, city)
VALUES ('Alex', 'alex@gmail.com', 25, 'Cluj');

INSERT INTO users (name, email, age, city)
VALUES('Maria', 'maria@gmail.com', 22, 'Bucharest');

-- SELECT

-- get everything
SELECT * FROM users; 

-- get specific columns
SELECT name, email FROM users;

-- get with condition
SELECT * FROM users WHERE age > 20 AND city = 'Cluj';

-- sort results 
SELECT * FROM users ORDER BY age ASC;
SELECT * FROM users ORDER BY age DESC;

-- limit results
SELECT * FROM users LIMIT 2;

-- count rows
SELECT COUNT(*) FROM users;


-- UPDATE
-- !!! Always use WHERE with UPDATE - without it you update every single row.

-- update one field
UPDATE users SET city = 'Timisoara' WHERE name = 'Alex';

-- update multiple fields
UPDATE users SET age = 21, city ='Cluj' WHERE name = 'Sergiu';


-- DELETE
-- !!! always use WHERE with DELETE - without it you delete everything

-- delete specific row
DELETE FROM users WHERE name = 'Maria';

-- delete with condition 
DELETE FROM users WHERE age < 21;


-- Where operators

-- =        equal
-- !=       not equal
-- >  <     greater/less than
-- >= <=    greater/less or equal
-- AND      both conditions true
-- OR       either condition true
-- NOT      negates condition
-- LIKE     pattern matching
-- IN       matches a list
-- BETWEEN  range

-- examples

SELECT * FROM users WHERE age BETWEEN 20 AND 25
SELECT * FROM users WHERE city IN ('Sibiu', 'Cluj');
SELECT * FROM users WHERE name LIKE '%S'; -- starts with S
SELECT * FROM users WHERE name LIKE 'u%'; -- ends with u

-- JOIN
-- This is where databases become powerful. Related data lives in separate tables and JOIN connects them.

-- tasks table linked to users
CREATE TABLE tasks (
    id SERIAL NUMBER KEY,
    title VARCHAR(200) NOT NULL,
    completed BOOLEAN DEFAULT FALSE,
    user_id INTEGER REFERENCES user(id) -- foreign key
);

-- insert tasks
INSERT INTO tasks (title, user_id) VALUES ('Learn SQL', 1);
INSERT INTO tasks (title, user_id) VALUES ('Build API', 1);
INSERT INTO tasks (title, user_id) VALUES ('Learn React', 2);

-- Join them:

SELECT users.name, tasks.title, tasks.completed
FROM tasks
JOIN users ON tasks.user_id = users.id;