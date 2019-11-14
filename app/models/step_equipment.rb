class StepEquipment < ApplicationRecord
  belongs_to :analyzed_instruction
  belongs_to :equipment
end
