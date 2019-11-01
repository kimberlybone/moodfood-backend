class Mood < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :users, through: :recipes
end
