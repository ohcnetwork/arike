Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index", as: :home

  get "/signup", to: "users#signup"
  get "/search", to: "search#index"
  resources :patients
  resources :users

  resources :sessions
  resources :lsg_bodies
end
