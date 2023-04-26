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
end