DROP DATABASE IF EXISTS digi_card;
CREATE DATABASE digi_card;

\c digi_card

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR(255) NOT NULL,
	password_digest VARCHAR(255) NOT NULL,
	email VARCHAR(255)
); 

CREATE TABLE cards(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	email VARCHAR(255),
	website VARCHAR(255),
	photo VARCHAR(255),
	linkedin VARCHAR(255),
	github VARCHAR(255),
	phone VARCHAR(255),
	background VARCHAR(255),
	owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE
	collector_id INTEGER REFERENCES users(id)
); 

