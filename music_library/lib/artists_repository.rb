require_relative './artists'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artist = []

    result_set.each do |record|
      artists = Artists.new
      artists.id = record['id']
      artists.name = record['name']
      artists.genre = record['genre']
      artist << artists
    end

    return artist
  end

  def find(id)
   sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
   sql_params = [id]

   result_set = DatabaseConnection.exec_params(sql, sql_params)

   record = result_set[0]

   artists = Artists.new
   artists.id = record['id']
   artists.name = record['name']
   artists.genre = record['genre']

   return artists
  end

  def create(artists)
    sql = 'INSERT INTO artists (name, genre) VALUES($1, $2);'
    sql_params = [artists.name, artists.genre]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(artists)
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    sql_params = [artists.name, artists.genre, artists.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end