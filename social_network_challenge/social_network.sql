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