class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  def analyze_mood
    # gather ingredients as a string
    byebug
    ing_str = self.ingredients.pluck(:name).join(' ')
    response = NLU.analyze(text: ing_str, features: {entities: {emotion: true, limit: 10, model: ENV['MODEL_ID']}})
    res = response.result
    mood = res['entities']
    # ing_mood = Mood.find_by(name: mood)
    # self.update(mood: ing_mood)
  end
end
