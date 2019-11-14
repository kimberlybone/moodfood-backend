class CreateStepEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :step_equipments do |t|
      t.belongs_to :analyzed_instruction, null: false, foreign_key: true
      t.belongs_to :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
