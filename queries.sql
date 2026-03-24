-- Creating tables

CREATE TABLE users (
    id SERIAL PRIMARY KEY, -- auto-incrementing number, unique identifier
    name VARCHAR(100) NOT NULL, -- text up to 100 characters & required, can't be null
    email VARCHAR(100) UNIQUE NOT NULL, -- no two users can have the same email
    age INTEGER, -- whole number, optional
    city VARCHAR(50) -- optional
)

