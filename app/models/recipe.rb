class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  def analyze_mood
    # gather ingredients as a string
    # byebug
    ing_str = self.ingredients.pluck(:name).join(' ')
    response = NLU.analyze(text: ing_str, features: {entities: {emotion: true, limit: 10, model: ENV['MODEL_ID']}})
    res = response.result
    mood = res['entities']

    str_mood_type = mood.map { |m| m['type'] }
    str_emotion = mood.map { |m| m['emotion'] }
    repeated_mood = str_mood_type.detect { |m| str_mood_type.count(m) > 1 }
    # iterate over str_emotion 
    if repeated_mood.exists? { str_emotion }
    byebug
    # ing_mood = Mood.find_by(name: mood)
    # self.update(mood: ing_mood)
  end
end
