DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS users;

-- Exercise 1
-- Create a users table with: id, name, email, age, city
-- Create a tasks table with: id, title, description, completed, user_id

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INTEGER,
    city VARCHAR(100)
);

CREATE TABLE tasks(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    completed BOOLEAN DEFAULT FALSE,
    user_id INTEGER REFERENCES users(id)
);

-- Exercise 2 — INSERT & SELECT
-- Insert 3 users
-- Insert 3 tasks assigned to different users
-- Select all users
-- Select only users from your city
-- Select all incomplete tasks

INSERT INTO users (name, email, age, city) VALUES ('Sergiu', 'sergiu@gmail.com', 20, 'Sibiu');
INSERT INTO users (name, email, age, city) VALUES ('Ionut', 'ionut@gmail.com', 22, 'Timisoara');
INSERT INTO users (name, email, age, city) VALUES ('Ana', 'ana@gmail.com', 23, 'Bucuresti');

INSERT INTO tasks (title, user_id) VALUES ('Learn Spanish', 1);
INSERT INTO tasks (title, user_id) VALUES ('Learn Python', 2);
INSERT INTO tasks (title, user_id) VALUES ('Go to gym', 1);

SELECT * FROM users ;
SELECT * FROM users WHERE city = 'Sibiu';
SELECT * FROM tasks WHERE completed = FALSE;

-- Exercise 3 — UPDATE & DELETE
-- Update one user's city
-- Mark one task as completed
-- Delete one user
-- Try deleting a user that has tasks — what happens?

UPDATE users SET city = 'Cluj' WHERE city = 'Bucuresti';
UPDATE tasks SET completed = TRUE WHERE id = 1;

DELETE from users WHERE name = 'Ana';

-- DELETE from users WHERE name = 'Sergiu';
-- It returns this error: update or delete on table "users" violates
-- foreign key constraint "tasks_user_id_fkey" on table "tasks"

-- This tells PostgreSQL: "every task must belong to a valid user". If 
-- you delete a user that has tasks, those tasks would point to a user that
-- no longer exists - a ghost reference. PostgreSQL prevents this automatically.

-- How to handle it in real projects
-- Option 1 - Delete the tasks first, then the user:
-- DELETE FROM tasks WHERE user_id = 1;
-- DELETE FROM users WHERE id = 1;

-- Option 2 - CASCADE delete - automatically deletes tasks when user is deleted:
-- define the foreign key like this
-- user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
-- now deleting a user automatically deletes all their tasks.

-- Option 3 - SET NULL - when user is deleted, tasks remain but user_id becomes NULL.
-- user_id INTEGER REFERENCES users(id) ON DELETE SET NULL


-- Exercise 4 — JOIN

-- Select all tasks with the name of the user they belong to
SELECT users.name, tasks.title
FROM tasks
JOIN users ON tasks.user_id = users.id;

-- Select only incomplete tasks with their user's name and email
SELECT users.name, users.email, tasks.completed
FROM tasks
JOIN users ON tasks.user_id = users.id WHERE completed = FALSE;

-- Count how many tasks each user has
SELECT  users.name, COUNT(tasks.id)
FROM tasks
JOIN users ON tasks.user_id = users.id GROUP BY users.name;