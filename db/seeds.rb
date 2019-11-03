# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'
User.destroy_all
Mood.destroy_all

kim = User.create(name: "Kim", email: "kim@gmail.com", location: "New York City", password: "1")
matt = User.create(name: "Matt", email: "mattisthecooliest@matt.matt", location: "NYC", password: "1")
sukrit = User.create(name: "Sukrit", email: "sukrit@sukrit.sukrit", location: "NYC", password: "1")
michelle = User.create(name: "Michelle", email: "michelle@michelle.michelle", location: "NYC", password: "1")
avi = User.create(name: "Avi", email: "avi@avi.avi", location: "NYC", password: "1")
javone = User.create(name: "Javone", email: "javone@javone.javone", location: "NYC", password: "1")

happy = Mood.create(name: "Happy|Energetic")
anxious = Mood.create(name: "Anxious")
adventurous = Mood.create(name: "Adventurous|Curious")
romantic = Mood.create(name: "Romantic")
stressed = Mood.create(name: "Stressed|Tense")
sad = Mood.create(name: "Sad")
calm = Mood.create(name: "Calm")
indifferent = Mood.create(name: "Indifferent")
angry = Mood.create(name: "Angry|Frustrated")

mood_array = ['happy', 'anxious', 'adventurous', 'romantic', 'stressed', 'sad', 'calm', 'indifferent', 'angry' ]
ingredient_array = ['cheese', 'chicken', 'egg', 'kale']

recipes = []

ingredient_array.each do |r_ingredient|
  recipe_ingredient_json = RestClient.get('https://api.spoonacular.com/recipes/find' + 'ByIngredients?number=50&ingredients=' + r_ingredient + '&apiKey=' + ENV['API_KEY'])
  recipe_ingredient_array = JSON.parse(recipe_ingredient_json)
  mood_array.each do |mood|
    recipe_ingredient_array.each do |recipe|
      recipe['mood'] = mood
    end
  end
  recipes << recipe_ingredient_array
  # byebug
end
recipes = recipes.flatten

recipes.each do |recipe|
  new_recipe = Recipe.create(
    name: recipe['title'],
    image: recipe['image'],
    user: kim,
    instructions: '1,2,3',
    mood: happy
  )
  # filtered_keys = recipe.keys.filter{|key| key.include?('ingredients') && recipe[key] != nil}
  # filtered_keys.each do |key|
  #   RecipeIngredient.create(
  #     recipe:
  #   )
end


# Use search recipes and look through each recipe to get ID then compare ID with "Get Recipe Information"
