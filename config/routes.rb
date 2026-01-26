Rails.application.routes.draw do
  get "books/index"
  get "books/show"
  get "books/edit"
  get "books/new"

  root "homes#top"
  get "about" => "homes#about"

  resources :users

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :sessions, only: [:new, :create, :destroy]
  resources :books
  
  get "up" => "rails/health#show", as: :rails_health_check
end
