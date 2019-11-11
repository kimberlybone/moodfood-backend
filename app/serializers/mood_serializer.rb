class MoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :recipes

  def recipes
    mood_recipes = Mood.all.map do |m|
      m.recipes
    end
    return mood_recipes
  end
end
