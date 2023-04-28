require 'artists_repository'

RSpec.describe 'artist repository class' do
      
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end

  it 'returns the list of aritsts' do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq(2)
    expect(artists.first.id).to eq('1')
    expect(artists.first.name).to eq 'Pixies'
  end

  it 'returns the Pixies as a single artists' do
    repo = ArtistRepository.new
    artists = repo.find(1)
    expect(artists.name).to eq 'Pixies'
    expect(artists.genre).to eq 'Rock'
  end
  
  it 'returns the ABBA as a single artists' do
    repo = ArtistRepository.new
    artists = repo.find(2)
    expect(artists.name).to eq 'ABBA'
    expect(artists.genre).to eq 'Pop'
  end

  it 'creates a new artist' do
    repo = ArtistRepository.new

    new_artists = Artists.new
    new_artists.name = 'Iron Maiden'
    new_artists.genre = 'Metal'

    repo.create(new_artists)

    artists = repo.all
    last_artists = artists.last

    expect(last_artists.name).to eq('Iron Maiden')
    expect(last_artists.genre).to eq('Metal')
  end

  it 'delete an artists with the id of 1' do
    repo = ArtistRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)
    all_artists = repo.all

    expect(all_artists.length).to eq 1
    expect(all_artists.first.id).to eq('2')
  end

  it 'delete the two artists' do
    repo = ArtistRepository.new

    repo.delete(1)
    repo.delete(2)
    all_artists = repo.all

    expect(all_artists.length).to eq 0
  end

  it 'updates the artist with new values (name, genre)' do
    repo = ArtistRepository.new

    artist = repo.find(1)

    artist.name = 'something'
    artist.genre = 'Disco'

    repo.update(artist)

    updated_artist = repo.find(1)

    expect(updated_artist.name).to eq('something')
    expect(updated_artist.genre).to eq('Disco')
  end

  it 'updates the artist with new values (name)' do
    repo = ArtistRepository.new

    artist = repo.find(1)

    artist.name = 'something'

    repo.update(artist)

    updated_artist = repo.find(1)

    expect(updated_artist.name).to eq('something')
    expect(updated_artist.genre).to eq('Rock')
  end
end