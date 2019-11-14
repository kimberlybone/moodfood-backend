class CreateAnalyzedInstructions < ActiveRecord::Migration[6.0]
  def change
    create_table :analyzed_instructions do |t|
      t.integer :step_number
      t.string :step_text
      t.belongs_to :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
