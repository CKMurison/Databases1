require "posts_repository"

RSpec.describe PostsRepository do
  def reset_users_table
    seed_sql = File.read("spec/posts_seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "SN_database_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_users_table
  end

  it "return the list of all users" do
    repo = PostsRepository.new

    post = repo.all
    expect(post.length).to eq (2)
    expect(post.first.user_account).to eq ("EpicCam")
    expect(post.first.title).to eq ("Best bean brands")
    expect(post.first.content).to eq ("Baked beans")
    expect(post.first.views).to eq ("1")
  end

  it "finds the first post" do
    repo = PostsRepository.new
    post = repo.find(1)
    expect(post.user_account).to eq ("EpicCam")
    expect(post.title).to eq "Best bean brands"
    expect(post.content).to eq "Baked beans"
    expect(post.views).to eq "1"
  end

  it "finds the second post" do
    repo = PostsRepository.new
    post = repo.find(2)
    expect(post.user_account).to eq ("Mergz")
    expect(post.title).to eq "The best omelet recipes"
    expect(post.content).to eq "Cheese ftw"
    expect(post.views).to eq "1000"
  end

  it "adds a new user" do
    repo = PostsRepository.new

    new_user = Posts.new
    new_user.user_account = "cm"
    new_user.title = "Big cm"
    new_user.content = "mc"
    new_user.views = "12345"

    repo.create(new_user)

    posts = repo.all
    last_user = posts.last

    expect(last_user.user_account).to eq "cm"
    expect(last_user.title).to eq "Big cm"
    expect(last_user.content).to eq "mc"
    expect(last_user.views).to eq "12345"
  end

  it "deletes a post" do
    repo = PostsRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)
    all_users = repo.all

    expect(all_users.length).to eq 1
    expect(all_users.first.user_account).to eq("Mergz")
    expect(all_users.first.title).to eq("The best omelet recipes")
    expect(all_users.first.content).to eq("Cheese ftw")
    expect(all_users.first.views).to eq("1000")
  end
end
