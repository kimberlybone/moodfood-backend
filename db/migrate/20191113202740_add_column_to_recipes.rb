class AddColumnToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :price_per_serving, :integer
    add_column :recipes, :vegetarian, :boolean
    add_column :recipes, :vegan, :boolean
    add_column :recipes, :glutenFree, :boolean
    add_column :recipes, :dairyFree, :boolean
    add_column :recipes, :preparationMinutes, :integer
    add_column :recipes, :cookingMinutes, :integer
    add_column :recipes, :servings, :integer
    add_column :recipes, :readyInMinutes, :integer
    add_column :recipes, :pairing_text, :string
  end
end
