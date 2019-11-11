
require 'rest-client'
require 'csv'
csv = CSV.read("./db/top-1k-ingredients.csv")
all_ingredients = csv.map do |ing_array|
  split_info = ing_array[0].split(';')
  ingredient = split_info[0]
end

all_ids = csv.map do |ing_array|
  split_info = ing_array[0].split(';')
  id = split_info[1]
end


User.destroy_all
Mood.destroy_all
Recipe.destroy_all
RecipeIngredient.destroy_all
Ingredient.destroy_all

# USER
kim = User.create(name: "Kim", email: "kim@gmail.com", location: "New York City", password: "1")
matt = User.create(name: "Matt", email: "mattisthecooliest@matt.matt", location: "NYC", password: "1")
sukrit = User.create(name: "Sukrit", email: "sukrit@sukrit.sukrit", location: "NYC", password: "1")
michelle = User.create(name: "Michelle", email: "michelle@michelle.michelle", location: "NYC", password: "1")
avi = User.create(name: "Avi", email: "avi@avi.avi", location: "NYC", password: "1")
javone = User.create(name: "Javone", email: "javone@javone.javone", location: "NYC", password: "1")

# MOOD
happy = Mood.create(name: "Happy")
anxious = Mood.create(name: "Anxious")
adventurous = Mood.create(name: "Adventurous")
romantic = Mood.create(name: "Romantic")
stressed = Mood.create(name: "Stressed")
sad = Mood.create(name: "Sad")
calm = Mood.create(name: "Calm")
indifferent = Mood.create(name: "Indifferent")
angry = Mood.create(name: "Angry")

kale_salad = Recipe.create(name: "Kale Salad",
                          user: kim,
                          mood: happy,
                          instructions: "1. Boil water with pasta 2. Drain water 3. Add sauce",
                          image: "https://www.gimmesomeoven.com/wp-content/uploads/2014/01/Kale-Cranberry-Salad-1.jpg")


noodles = Ingredient.create(name: "kale", image: "kflfk", api_id: 1)
cheese = Ingredient.create(name: "plum", image: "kflfk", api_id: 2)
noodles = Ingredient.create(name: "apples are cool", image: "kflfk", api_id: 1)
cheese = Ingredient.create(name: "beets battle star", image: "kflfk", api_id: 2)
noodles = Ingredient.create(name: "tuna sandwich", image: "kflfk", api_id: 1)
cheese = Ingredient.create(name: "ginger", image: "kflfk", api_id: 2)

Ingredient.all.each do |ing|
  RecipeIngredient.create(name: "RecipeIngredient", recipe: kale_salad, ingredient: ing)
end


mood_array = ['happy', 'anxious', 'adventurous', 'romantic', 'stressed', 'sad', 'calm', 'indifferent', 'angry' ]

recipes = []

all_ingredients[0..2].each do |ing_name|

  # fetch to ingredient find by ingredient API
  recipe_by_ingredient_json = RestClient.get('https://api.spoonacular.com/recipes/find' + 'ByIngredients?number=50&ingredients=' + ing_name + '&apiKey=' + ENV['API_KEY'])
  recipe_by_ingredient_array = JSON.parse(recipe_by_ingredient_json)
  # iterate through API response


  recipe_id = recipe_by_ingredient_array.map do |ri|
    ri['id']
  # fetch to recipe info API with id
  end

  temp_recipes = recipe_id[0..2].map do |id|
    recipe_info_json = RestClient.get('https://api.spoonacular.com/recipes/' + id.to_s + '/information?apiKey=' + ENV['API_KEY'])
    recipe_info_object = JSON.parse(recipe_info_json)
    # push inside iteration since fetches one at a time
    byebug
    recipe_info_object
  end

  # add 'mood' key to each recipe to match with a mood
  temp_recipes.each do |recipe|
    mood_array.each do |mood|
      recipe['mood'] = mood
    end
  end

  recipes << temp_recipes
end

recipes = recipes.flatten

# RECIPE & RECIPE INGREDIENT
recipes.each do |recipe|
  new_recipe = Recipe.create(
    name: recipe['title'],
    image: recipe['image'],
    user: kim,
    instructions: recipe['instructions'],
    mood: Mood.first
  )
  # filtered_keys = recipe.keys.filter{|key| key.include?('Ingredients') && recipe[key] != nil}
  # iterate through each hash of recipe ingredients
  recipe['extendedIngredients'].each do |obj|
    # can set this to variable & put var as val for ingredient
      Ingredient.find_or_create_by(api_id: obj['id'], name: obj['name'], image: obj['image'])
      RecipeIngredient.create(
        recipe: new_recipe,
        ingredient: Ingredient.find_by(name: obj['name']),
        name: obj['originalString']
      )
  end
end


# Use search recipes and look through each recipe to get ID then compare ID with "Get Recipe Information"
