Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index", as: :home

  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/search", to: "search#index"

  put "/users/:id/verify", to: "users#verify", as: :verify_user

  resources :patients
  resources :users
  get "/patients/:id/view/details/edit", to: "patients#family_details", as: :patient_details

  post "sessions/signup", to: "sessions#signup", as: :signup
  resources :sessions

  get "/password_reset", to: "password_reset#index", as: :password_reset
  get "/password_reset/verify", to: "password_reset#verify", as: :password_reset_verify
  get "/schedule", to: "schedule#index", as: :schedule

  resources :lsg_bodies
  resources :wards
end
