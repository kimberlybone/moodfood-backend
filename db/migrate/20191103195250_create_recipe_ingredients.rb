class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
      t.recipe :belongs_to
      t.ingredient :belongs_to
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
