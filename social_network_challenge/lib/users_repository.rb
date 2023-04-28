require_relative "users"

class UsersRepository
  def all
    # Executes the SQL query:
    sql = "SELECT id, email_address, user_name FROM users;"
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
      user = Users.new
      user.email_address = record["email_address"]
      user.user_name = record["user_name"]

      users << user
    end
    return users
  end

  def find(id)
    sql = "SELECT id, email_address, user_name FROM users WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    user = Users.new
    user.email_address = record["email_address"]
    user.user_name = record["user_name"]

    return user
  end

  def create(users)
    sql = "INSERT INTO users (email_address, user_name) VALUES ($1, $2);"
    sql_params = [users.email_address, users.user_name]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def delete(id)
    sql = "DELETE FROM users WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
