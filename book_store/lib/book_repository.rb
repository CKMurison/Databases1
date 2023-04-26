require_relative './book'

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])

    books = []
    result_set.each do |novels|
      book = Book.new
      book.id = novels['id']
      book.title = novels['title']
      book.author_name = novels['author_name']
      books << book
    end

    return books
  end
end