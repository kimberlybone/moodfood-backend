class AnalyzedInstruction < ApplicationRecord
  belongs_to :recipe
  has_many :step_equipments, dependent: :destroy
  has_many :equipments, through: :step_equipments
end
