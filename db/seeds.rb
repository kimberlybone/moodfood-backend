# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Mood.destroy_all

kim = User.create(name: "Kim", email: "kim@gmail.com", location: "New York City", password: "1")
matt = User.create(name: "Matt", email: "mattisthecooliest@matt.matt", location: "NYC", password: "1")
sukrit = User.create(name: "Sukrit", email: "sukrit@sukrit.sukrit", location: "NYC", password: "1")
michelle = User.create(name: "Michelle", email: "michelle@michelle.michelle", location: "NYC", password: "1")
avi = User.create(name: "Avi", email: "avi@avi.avi", location: "NYC", password: "1")
javone = User.create(name: "Javone", email: "javone@javone.javone", location: "NYC", password: "1")

happy = Mood.create(name: "Happy|Energetic")
anxious = Mood.create(name: "Anxious")
adventurous = Mood.create(name: "Adventurous|Curious")
romantic = Mood.create(name: "Romantic")
stressed = Mood.create(name: "Stressed|Tense")
sad = Mood.create(name: "Sad")
calm = Mood.create(name: "Calm")
indifferent = Mood.create(name: "Indifferent")
happy = Mood.create(name: "Angry|Frustrated")
