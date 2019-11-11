require "ibm_watson/authenticators"
require "ibm_watson/natural_language_understanding_v1"
include IBMWatson

class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  AUTHENTICATOR = Authenticators::IamAuthenticator.new(
    apikey: ENV['AI_API_KEY']
  )
  NLU = NaturalLanguageUnderstandingV1.new(
    version: "2019-07-12",
    authenticator: AUTHENTICATOR
  )


  def self.new_token
    NLU.service_url = "https://gateway.watsonplatform.net/natural-language-understanding/api"
    # response = NLU.analyze( url: "www.cnn.com", features: {entities: {sentiment: true, limit: 10, model: ENV['MODEL_ID']}})
    # JSON.pretty_generate(response.result)
  end


  def analyze_mood
    Recipe.new_token
    ing_str = self.ingredients.pluck(:name).join(' ')
    response = NLU.analyze(text: ing_str, features: {entities: {emotion: true, limit: 10, model: ENV['MODEL_ID']}})
    res = response.result
    mood = res['entities']

    str_mood_type_array = mood.map { |m| m['type'] }
    emotion_array = mood.map { |m| m['emotion'] }
    max_emotion = str_mood_type_array.detect { |m| str_mood_type_array.count(m) > 1 }

    if str_mood_type_array.length <= 1
      new_mood = str_mood_type_array[0].downcase.capitalize
    elsif max_emotion
      new_mood = max_emotion.downcase.capitalize
    else
      max_emotion_array = emotion_array[0].map do |emotion_hash|
        emotion_hash.max_by{|x,y| y}
      end

      max_emotion = max_emotion_array[0]
      new_mood = max_emotion.capitalize

      case new_mood
        when 'Joy'
          new_mood = 'Happy'
        when 'Sadness'
          new_mood = 'Sad'
        when 'Fear'
          new_mood = 'Adventurous'
        when 'Anger'
          new_mood = 'Angry'
        when 'Digust'
          new_mood = 'Stressed'
        else
          new_mood = 'Indifferent'
      end

      return new_mood
    end
    ing_mood = Mood.find_by(name: new_mood)
    self.update(mood: ing_mood)
  end

end
