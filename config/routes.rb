Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  # opening endpoint to test autocomplete in the browser
  get "/auto" => "home#auto"

  get "/signup", to: "users#signup"
  resources :patients
  resources :users

  resources :sessions
  resources :lsg_bodies
end
