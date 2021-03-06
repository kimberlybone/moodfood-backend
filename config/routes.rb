Rails.application.routes.draw do
  resources :step_equipments
  resources :equipment
  resources :analyzed_instructions
  resources :recipe_ingredients
  resources :ingredients
  resources :recipes
  resources :moods
  resources :users

  post '/login', to: 'login#create', as: 'login'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
