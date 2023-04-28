require "users_repository"

RSpec.describe UsersRepository do
  def reset_users_table
    seed_sql = File.read("spec/user_seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "SN_database_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_users_table
  end

  it "return the list of all users" do
    repo = UsersRepository.new

    user = repo.all
    expect(user.length).to eq (2)
    expect(user.first.user_name).to eq ("EpicCam")
    expect(user.first.email_address).to eq "cameron@gmail"
  end

  it "finds user 1" do
    repo = UsersRepository.new
    user = repo.find(1)
    expect(user.email_address).to eq "cameron@gmail"
    expect(user.user_name).to eq "EpicCam"
  end

  it "finds user 2" do
    repo = UsersRepository.new
    user = repo.find(2)
    expect(user.email_address).to eq "mergim@yahoo"
    expect(user.user_name).to eq "Mergz"
  end

  it "adds a new user" do
    repo = UsersRepository.new

    new_user = Users.new
    new_user.email_address = "Jim@bing"
    new_user.user_name = "Big Jim"

    repo.create(new_user)

    users = repo.all
    last_user = users.last

    expect(last_user.email_address).to eq "Jim@bing"
    expect(last_user.user_name).to eq "Big Jim"
  end
  it "deletes a user" do
    repo = UsersRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_users = repo.all
    expect(all_users.length).to eq 1
    expect(all_users.first.id).to eq("2")
  end
end
