class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many  :moods, through: :recipes

  validates :name, uniqueness: true, presence: true
  # validates :age, numericality: { greater_than: 20, message: "must be 21 or older. Try again next time. "}, presence: true
  # validates :budget, numericality: { less_than: 500, message: "must be less than $500. "}, presence: true

  has_secure_password
end
