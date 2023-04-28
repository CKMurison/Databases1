require_relative "posts"

class PostsRepository
  def all
    # Executes the SQL query:
    sql = "SELECT id, user_account, title, content, views FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Posts.new
      post.user_account = record["user_account"]
      post.title = record["title"]
      post.content = record["content"]
      post.views = record["views"]

      posts << post
    end
    return posts
  end

  def find(id)
    sql = "SELECT id, user_account, title, content, views FROM posts WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    post = Posts.new
    post.user_account = record["user_account"]
    post.title = record["title"]
    post.content = record["content"]
    post.views = record["views"]

    return post
  end

  def create(posts)
    sql = "INSERT INTO posts (user_account, title, content, views) VALUES ($1, $2, $3, $4);"
    sql_params = [posts.user_account, posts.title, posts.content, posts.views]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
