require 'recipe_repository'
require 'recipe'

RSpec.describe RecipeRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes_database.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_database_test' })
    connection.exec(seed_sql)
  end

  describe RecipeRepository do
    before(:each) do 
      reset_recipes_table
    end
  end

  it 'returns a list of recipes' do
    repo = RecipeRepository.new
    recipe = repo.all
    p recipe
    expect(recipe.length).to eq '2'
    expect(recipes[0].id).to eq '1'
    expect(recipes[0].name).to eq('Spam')
    expect(recipes[0].cooking_time).to eq('5')
    expect(recipes[0].rating).to eq('5')
    expect(recipes[1].id).to eq '2'
    expect(recipes[1].name).to eq('Pancakes')
    expect(recipes[1].cooking_time).to eq('20')
    expect(recipes[1].rating).to eq('5')
  end

  it 'returns Spam' do
    repo = RecipeRepository.new
    recipe = repo.find(1)
    expect(recipes[0].id).to eq '1'
    expect(recipes[0].name).to eq('Spam')
    expect(recipes[0].cooking_time).to eq('5')
    expect(recipes[0].rating).to eq('5')
   
  end

  it 'returns Pancakes' do
    repo = RecipeRepository.new
    recipe = repo.find(2)
    expect(recipe.id).to eq('2')
    expect(recipe.name).to eq('Pancakes')
    expect(recipe.cooking_time).to eq('20')
    expect(recipe.rating).to eq('5')
  end
end