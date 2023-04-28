require_relative 'posts'

class PostsRepository
  def all
    # Executes the SQL query:
    sql = "SELECT id, user_account, title, content, views FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Users.new
      post.user_account = record['user_account']
      post.title = record['title']
      post.content = record["content"]
      post.views = record["views"]

      posts << post
    end
  return posts
  end
end