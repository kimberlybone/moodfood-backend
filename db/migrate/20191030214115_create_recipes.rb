class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :mood, null: false, foreign_key: true
      t.string :instructions
      t.string :image

      t.timestamps
    end
  end
end
