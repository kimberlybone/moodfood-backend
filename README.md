# **MoodFood Backend**

My application uses artificial intelligence to suggest recipes based on a user's current mood in order to enhance it.

---

## Motivation
Think of a time when someone asked what you wanted to eat. Usually our response is influenced by a current feeling we are trying to fulfill. As a nutrition science graduate, I'm always looking at the correlation between nutrients and psychology...or how specific nutrients affect how I feel. So I wanted to create an application that would give me food suggestions based on how I am currently feeling.

## Features

- Filter by diet preference
- Ingredient show page
- Profile page
- Slideshow of recipes
- Make account and log in
- Validations on account information

## DEMO

## Instructions
1. A user can log in or sign up

2. Pick the mood you are currently feeling
3. View the slideshow of recipes for the chosen mood
4. Can click on recipe picture to redirect to recipe show page
5. To view all recipes, click on "Home"
6. Can click on down arrow of each recipe card to see instructions
7. Can filter by diet at the top of the Home page
8. User can click on recipe picture to be redirected to that recipe's show page
9. In the navigation bar, the user can click on the "Profile" tab to see their profile information

## Technologies
- IBM Watson Natural Language Understanding
- IBM Watson Knowledge Studio
- Spoonacular API: (https://api.spoonacular.com/recipes/id/information?apiKey=API_KEY) & (https://api.spoonacular.com/recipes/findByIngredients?number=50&ingredients=ingredient_name&apiKey=API_KEY)
- Ruby on Rails
- PostgreSQL
- JWT Auth
- BCrypt
- ActiveRecord
- ActiveModel Serializers
- RestClient

## Installation
*To view live version, go to this URL:[]()*

*To view locally, follow the instructions below*
1. Clone repository

  ```
  bundle install
  rails db:create
  rails db:migrate
  rails db:seed
  rails server
  ```
- Server needs to run on http://localhost:3000

2. Go to frontend repository to view frontend installation

---
***Authors: [Kimberly Bone](https://github.com/kimberlybone)***
