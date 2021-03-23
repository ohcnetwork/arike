Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index", as: :home

  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/search", to: "search#index"
  get "/schedule", to: "schedule#index", as: :schedule

  put "/users/:id/verify", to: "users#verify", as: :verify_user

  resources :patients
  resources :users
  get "/patients/:id/view/details/edit", to: "patients#family_details", as: :patient_details

  post "/sessions/signup", to: "sessions#signup", as: :signup

  get "/password_reset", to: "password_reset#index", as: :password_reset
  post "/password_reset", to: "password_reset#send_mail", as: :password_reset_send_mail
  get "/password_reset/verify", to: "password_reset#verify", as: :password_reset_verify
  post "/password_reset/verify", to: "password_reset#reset", as: :password_reset_update

  resources :sessions
  resources :lsg_bodies
  resources :wards
end
