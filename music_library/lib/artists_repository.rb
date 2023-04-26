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
end