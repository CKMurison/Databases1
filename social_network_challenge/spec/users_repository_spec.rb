require "users_repository"

RSpec.describe UsersRepository do

    def reset_users_table
    seed_sql = File.read("spec/user_seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "SN_database" })
    connection.exec(seed_sql)
    end

    describe UsersRepository do
    before(:each) do
        reset_users_table
    end
    end

    it "return the list of all users" do
    repo = UsersRepository.new

    user = repo.all
    user.length => 2
    user.first.id => 1
    expect(user.first.email_address).to eq "cameron@gmail"
    end
end