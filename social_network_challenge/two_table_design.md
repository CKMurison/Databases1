Two Tables Design Recipe Template

Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns:  

student_name, cohort_name, starting_date, student_cohorts
2. Infer the Table Name and Columns

| table_name            | Properties          |
| --------------------- | ------------------  |
| users                 | email_address, user_name
| posts                 | user_account, title, content, views

Put the different nouns in this table. Replace the example with your own nouns.

Record	Properties
posts,	title, content
comments,  content, names
Name of the first table (always plural): users

Column users: email_address, user_name

Name of the second table (always plural): posts

Column posts: user_account, title, content, views

3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: users
id: SERIAL
email_address: text
user_name: text

Table: posts
id: SERIAL
user_account: text
title: text
content: text
views: int

4. Decide on The Tables Relationship

Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can a user have many posts? YES
Can a post have many users? NO

users -> one-to-many -> posts

The foregin key is on posts(user_id)


4. Write the SQL.

-- EXAMPLE
-- file: social_network_table.sql

-- Replace the table name, columm names and types.

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_account text,
  title text,
  content text,
  views int
);


-- Then the table with the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email_address text,
  user_name text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
	constraint fk_post foreign key (post_id) references posts(id)
);

5. Create the tables.

psql -h 127.0.0.1 student_directory < students_table.sql