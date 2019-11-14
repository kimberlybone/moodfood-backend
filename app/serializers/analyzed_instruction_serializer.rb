class AnalyzedInstructionSerializer < ActiveModel::Serializer
  attributes :id, :step_number, :step_text, :equipments, :recipe
end
