Artists Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: students

Columns:
id | name | cohort_name
2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_SN_database.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# Table name: users

# Table name: posts


# Model class
# (in lib/users.rb)
class Users
  attr_reader: _____
end


# Model class
# (in lib/posts.rb)
class Posts
  attr_reader: _____
end


# Repository class
# (in lib/users_repository.rb)
class UsersRepository

end

# (in lib/posts_repository.rb)
class PostsRepository

end


5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: users

# Repository class
# (in lib/users_repository.rb)

class UsersRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, user_name FROM users;

    # Returns an array of User objects.
  end

  # Select a single record
  # Given the id in arguemnt (a number)
  def find(id)
   # Executes the SQL query
   # SELECT id, email_address, user_name, FROM users WHERE id = $1; 
  end

  # inserts a new users record
  # Takes an Users object as an argument
  def create(users)
   # Executes SQL query
   # INSERT INTO users (email_address, user_name) VALUES(¢1, ¢2);

   # Doesn't need to return anything (only creates a record)
   # return nil
  end

  # Deletes an users record
  # Given its id
  def delete(id)
   # Executes the SQL
   # DELETE FROM users WHERE id = $1;

   # Returns nothing (only deletes the record)
   # return nil
  end

  # Updates the users record
  # Take an Users object (with the updated fields)
  def update(users)
   # Executes the sql query
   # UPDATE users SET email_address = $1, user_name = $2 WHERE id = $3;

   # Returns nothing (only updates the record)
   # returns nil
  end

  # end
end


# EXAMPLE
# Table name: posts

# Repository class
# (in lib/posts_repository.rb)

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, user_account, title, content, views FROM posts;

    # Returns an array of User objects.
  end

  # Select a single record
  # Given the id in arguemnt (a number)
  def find(id)
   # Executes the SQL query
   # SELECT id, user_account, title, content, views FROM posts WHERE id = $1; 
  end

  # inserts a new users record
  # Takes an Users object as an argument
  def create(posts)
   # Executes SQL query
   # INSERT INTO posts (user_account, title, content, views) VALUES($1, $2, $3, $4) ;

   # Doesn't need to return anything (only creates a record)
   # return nil
  end

  # Deletes an users record
  # Given its id
  def delete(id)
   # Executes the SQL
   # DELETE FROM posts WHERE id = $1;

   # Returns nothing (only deletes the record)
   # return nil
  end

  # Updates the users record
  # Take an Users object (with the updated fields)
  def update(posts)
   # Executes the sql query
   # UPDATE posts SET user_account = $1, title = $2, content = $3, views = $4 WHERE id = $5;
   
   # Returns nothing (only updates the record)
   # returns nil
  end

  # end
end
6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all Users

repo = UsersRepository.new

user = repo.all
user.length => 2
user.first.id => 1
user.first.email_address => 'cameron@gmail'

# 2 
# Find a certian user

    repo = UsersRepository.new
    user = repo.find(1)
    expect(user.email_address).to eq 'cameron@gmail'
    expect(user.user_name).to eq 'EpicCam'

    repo = UsersRepository.new
    user = repo.find(2)
    expect(user.email_address).to eq 'mergim@yahoo'
    expect(user.user_name).to eq 'Mergz'

# 3 Create new user

    repo = UsersRepository.new

    new_user = Users.new
    new_user.email_address = 'Jim@bing'
    new_user.user_name = 'Big Jim'

    repo.create(new_user)

    users = repo.all
    last_user = users.last

    expect(last_users.email_address).to eq('Jim@bing')
    expect(last_users.user_name).to eq('Big Jim')


# 4 Delete an user

repo = UsersRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_users = repo.all
all_users.length => 1
all_users.first.id => 2


# 1
# Get all Posts

repo = PostsRepository.new

post = repo.all
post.length => 4
post.first.id => 1
post.first.user_account => 'EpicCam'

# 2 
# Find a certian post

    repo = PostsRepository.new
    post = repo.find(1)
    expect(user.user_account).to eq 'EpicCam'
    expect(user.title).to eq 'Best bean brands'
    expect(user.content).to eq 'Baked beans'
    expect(user.views).to eq '1'

    repo = PostsRepository.new
    post = repo.find(4)
    expect(user.user_account).to eq 'Mergz'
    expect(user.title).to eq 'The best omelet recipes'
    expect(user.content).to eq 'Cheese ftw'
    expect(user.views).to eq '1000'

# 3 Create new Posts

    repo = PostsRepository.new

    new_post = Posts.new
    new_post.user_account = 'cm'
    new_post.title = 'Big cm'
    new_post.content = 'mc'
    new_post.views = '12345'

    repo.create(new_post)

    posts = repo.all
    last_post = posts.last

    expect(last_post.user_account).to eq('cm')
    expect(last_post.title).to eq('Big cm')
    expect(last_post.content).to eq('mc')
    expect(last_post.views).to eq('Big 12345')

# 4 Delete an Posts

repo = PostsRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_posts = repo.all
all_posts.length => 3
all_posts.first.id => 2




7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/users_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/user_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'SN_database' })
  connection.exec(seed_sql)
end

describe UsersRepository do
  before(:each) do 
    reset_users_table
  end

  # file: spec/posts_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/posts_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'SN_database' })
  connection.exec(seed_sql)
end

describe PostsRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.