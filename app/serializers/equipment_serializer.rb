class EquipmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :analyzed_instructions
end
