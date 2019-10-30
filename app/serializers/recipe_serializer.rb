class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :image
  has_one :user
  has_one :mood
end
