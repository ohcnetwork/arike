Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index"

  # get "/patients/:id/view/details/edit", to: "patients#family_details", as: :patient_details
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/search", to: "search#index"
  get "/schedule", to: "schedule#index", as: :schedule
  post "/schedule", to: "schedule#schedule"

  # patients
  resources :patients
  # disease summary
  resources :patient_disease_summaries
  get "/patients/:id/disease_history", to: "patient_disease_summaries#index", as: :disease_history
  put "/patients/:id/patient_disease_summary/", to: "patient_disease_summaries#update"
  # family_details
  get "/patients/:id/family_details", to: "family_details#index", as: :family_details
  put "/patients/:id/family_details/", to: "family_details#update"
  # patient information
  get "/patients/:id/show/family_details", to: "patients#show", as: :show_family_details
  get "patients/:id/show/personal_details", to: "patients#show", as: :show_personal_details
  get "/patients/:id/show/disease_history", to: "patients#show", as: :show_disease_history


  resources :users
  put "/users/:id/verify", to: "users#verify", as: :verify_user
  # for assigning a nurse to a facility
  put "/assign", to: "users#assign_facility", as: :assign_facility
  # for removing a nurse from a facility
  put "/unassign", to: "users#unassign_facility", as: :unassign_facility

  # get "/patients/:id/view/details/edit", to: "patients#family_details", as: :patient_details

  get "/signup", to: "users#signup", as: :signup

  get "/password_reset", to: "password_reset#index", as: "password_reset_page"
  post "/password_reset/send_otp", to: "password_reset#send_otp"
  post "/password_reset/verify", to: "password_reset#verify"
  post "/password_reset/update", to: "password_reset#update"

  get "logout", to: "sessions#logout"

  # visit_details
  get "/visit_details/decision", to: "visit_details#decision"
  post "/visit_details/assign_to", to: "visit_details#assign_to"
  post "/visit_details/schedule_revisit", to: "visit_details#schedule_revisit"
  post "/visit_details/expired", to: "visit_details#expired"

  resources :sessions
  resources :facilities
  # get users belonging to a facility
  get "/facilities/:id/users", to: "facilities#show_users", as: :show_facility_users
  get "/facilities/:id/patients", to: "facilities#show_patients", as: :show_facility_patients
  resources :lsg_bodies
  resources :wards

  resources :visit_details
  resources :sessions
  resources :facilities
  resources :lsg_bodies
  resources :wards
end
