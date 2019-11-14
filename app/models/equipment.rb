class Equipment < ApplicationRecord
  has_many :step_equipments, dependent: :destroy
  has_many :analyzed_instructions, through: :step_equipments
end
