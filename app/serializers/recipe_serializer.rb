class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :analyzed_instructions, :image, :ingredients, :recipe_ingredients, :price_per_serving, :vegetarian, :vegan, :glutenFree, :dairyFree, :preparationMinutes, :cookingMinutes, :servings, :readyInMinutes, :pairing_text
  has_one :user

  # has_one :mood
end
