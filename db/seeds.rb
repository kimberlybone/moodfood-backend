require 'pry'
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

StepEquipment.destroy_all
AnalyzedInstruction.destroy_all
RecipeIngredient.destroy_all
Recipe.destroy_all
User.destroy_all
Mood.destroy_all
Ingredient.destroy_all
Equipment.destroy_all

User.reset_pk_sequence
Mood.reset_pk_sequence
Recipe.reset_pk_sequence
RecipeIngredient.reset_pk_sequence
Ingredient.reset_pk_sequence
StepEquipment.reset_pk_sequence
AnalyzedInstruction.reset_pk_sequence
Equipment.reset_pk_sequence

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


# Ingredient.all.each do |ing|
#   RecipeIngredient.create(name: "RecipeIngredient", recipe: kale_salad, ingredient: ing)
# end

# mood_array = ['happy']
recipe_id_array = []

all_ingredients[0..6].each do |ing_name|

  # FETCH TO INGREDIENT FOR FIND BY INGREDIENT API
  recipe_by_ingredient_json = RestClient.get('https://api.spoonacular.com/recipes/find' + 'ByIngredients?number=50&ingredients=' + ing_name + '&apiKey=' + ENV['API_KEY'])
  recipe_by_ingredient_array = JSON.parse(recipe_by_ingredient_json)

  # ITERATE THROUGH API RESPONSE 
  recipe_by_ingredient_array.each do |ri|
    recipe_id_array << ri['id']
    # fetch to recipe info API with id
  end
end
 new_recipe_id_array = recipe_id_array.uniq

 # FETCH INDIVIDUAL RECIPES
 # recipes = []

 binding.pry
 recipes = new_recipe_id_array[0..6].map do |id|
    recipe_info_json = RestClient.get('https://api.spoonacular.com/recipes/' + id.to_s + '/information?apiKey=' + ENV['API_KEY'])
    recipe_info_object = JSON.parse(recipe_info_json)
    recipe_info_object
  end

  # add 'mood' key to each recipe to match with a mood
  # recipes.each do |recipe|
  #   mood_array.each do |mood|
  #     recipe['mood'] = mood
  #   end
  # end


# recipes = recipes.flatten

# CREATE RECIPES & RECIPE INGREDIENTS
recipes.each do |recipe|
  new_recipe = Recipe.create(
    name: recipe['title'],
    image: recipe['image'],
    user: kim,
    instructions: recipe['instructions'],
    price_per_serving: recipe['pricePerServing'],
    vegetarian: recipe['vegetarian'],
    vegan: recipe['vegan'],
    glutenFree: recipe['glutenFree'],
    dairyFree: recipe['dairyFree'],
    preparationMinutes: recipe['preparationMinutes'],
    cookingMinutes: recipe['cookingMinutes'],
    servings: recipe['servings'],
    readyInMinutes: recipe['readyInMinutes'],
    pairing_text: recipe['winePairing']['pairingText'],
    mood: Mood.first
  )

  recipe['analyzedInstructions'].each do |obj|
    obj['steps'].each do |step_obj|
      analyzed_instructions = AnalyzedInstruction.create(step_number: step_obj['number'], step_text: step_obj['step'], recipe: new_recipe)

        step_obj['equipment'].each do |equip|
          equipment = Equipment.find_or_create_by(name: equip['name'], image: equip['image'])
          StepEquipment.create(
            analyzed_instruction: analyzed_instructions,
            equipment: equipment
          )
      end
    end
  end

  recipe['extendedIngredients'].each do |obj|
      Ingredient.find_or_create_by(api_id: obj['id'], name: obj['name'], image: obj['image'])
      RecipeIngredient.create(
        recipe: new_recipe,
        ingredient: Ingredient.find_by(name: obj['name']),
        name: obj['originalString']
      )
  end
  new_recipe.analyze_mood
end


# Use search recipes and look through each recipe to get ID then compare ID with "Get Recipe Information"


# recipe['analyzedInstructions'].each do |obj|
#   obj['steps'].each do |step_obj|
#     puts "💎💎💎💎💎"
#     puts step_obj['equipment']
#     equip = step_obj['equipment'].first
#     equipment = Equipment.find_or_create_by(name: equip['name'], image: equip['image'])
#     puts "💎💎💎💎💎"
#   end
# end
#
#
# StepEquipment.create(
#   analyzed_instructions_id: 1,
#   equipment_id: equipment.id
# )
