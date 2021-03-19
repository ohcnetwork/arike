Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index", as: :home

  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/signup", to: "users#signup"
  get "/search", to: "search#index"

  put "/users/:id/verify", to: "users#verify", as: :verify_user

  resources :patients
  resources :users

  resources :sessions
  resources :lsg_bodies
end
