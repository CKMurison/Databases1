require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

DatabaseConnection.connect('book_store')

result = DatabaseConnection.exec_params('SELECT * FROM books;', [])

books = BookRepository.new

books.all.each do |record|
  p record
end
