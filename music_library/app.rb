require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'

DatabaseConnection.connect('music_library')

result = DatabaseConnection.exec_params('SELECT * FROM artists;', [])

artists = ArtistRepository.new

#artists.all.each do |artists|
#  p artists
#end


time = artists.find(4)
puts time.name