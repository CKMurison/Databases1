require "posts_repository"

RSpec.describe PostsRepository do
  def reset_posts_table
    seed_sql = File.read("spec/posts_seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "SN_database_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  it "return the list of all users" do
    repo = PostsRepository.new

    post = repo.all
    expect(post.length).to eq (2)
    expect(post.first.user_account).to eq ("EpicCam")
    expect(post.first.title).to eq "Best bean brands"
    expect(post.first.content).to eq "Baked beans"
    expect(post.first.views).to eq "1"
  end
end