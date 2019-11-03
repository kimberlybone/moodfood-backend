Rails.application.routes.draw do
  resources :ingredients
  resources :recipes
  resources :moods
  resources :users

  post '/login', to: 'login#create', as: 'login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
