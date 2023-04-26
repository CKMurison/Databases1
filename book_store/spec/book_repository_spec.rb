require 'book_repository'

RSpec.describe BookRepository do 
  
  def reset_books_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end
  
  
  it 'returns all the books with id, title & authors name' do
    repo = BookRepository.new
    books = repo.all
    expect(books.length).to eq 2
    expect(books[0].id).to eq '1'
    expect(books[0].title).to eq 'Dune'
    expect(books[0].author_name).to eq 'Frank Herbert'
    expect(books[1].id).to eq '2'
    expect(books[1].title).to eq 'Mythos'
    expect(books[1].author_name).to eq 'Stephen Fry' 
  end
end