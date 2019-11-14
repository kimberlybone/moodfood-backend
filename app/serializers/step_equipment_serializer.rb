class StepEquipmentSerializer < ActiveModel::Serializer
  attributes :id
  has_one :analyzed_instructions_id
  has_one :equipment_id
end
