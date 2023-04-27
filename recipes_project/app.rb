require_relative 'lib/recipe_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('recipes_database_test')

repo = RecipeRepository.new

repo.all.each do |recipe|
  puts recipe
end

#artists.all.each do |artists|
#  p artists
#end