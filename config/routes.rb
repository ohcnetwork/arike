Rails
  .application
  .routes
  .draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index"

  # Public change log
  scope "changelog", as: "changelog", controller: "changelog" do
    get "(/:year)", action: "index"
  end

  # get "/patients/:id/view/details/edit", to: "patients#family_details", as: :patient_details
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/search", to: "search#index"
  get "/schedule", to: "schedule#index", as: :schedule
  post "/schedule", to: "schedule#schedule"

  # patients
  resources :patients do
    get "/disease_history",
        to: "patient_disease_summaries#index",
        as: :disease_history
    put "/patient_disease_summary/", to: "patient_disease_summaries#update"

    # family_details
    get "/family_details", to: "family_details#index", as: :family_details
    put "/family_details/", to: "family_details#update"

    # patient information
    get "/show/family_details",
        to: "patients#show_detail",
        as: :show_family_details
    get "/show/personal_details",
        to: "patients#show_detail",
        as: :show_personal_details
    get "/show/disease_history",
        to: "patients#show_detail",
        as: :show_disease_history
  end

  # get '/stories', to: redirect('/articles')

  # for assigning a nurse to a facility
  put "/assign", to: "users#assign_facility", as: :assign_facility

  # for removing a nurse from a facility
  put "/unassign", to: "users#unassign_facility", as: :unassign_facility

  # get "/patients/:id/view/details/edit", to: "patients#family_details", as: :patient_details

  # visit_details
  get "/visit_details/decision", to: "visit_details#decision"
  post "/visit_details/assign_to", to: "visit_details#assign_to"
  post "/visit_details/schedule_revisit", to: "visit_details#schedule_revisit"
  post "/visit_details/expired", to: "visit_details#expired"

  # get users belonging to a facility
  get "/facilities/:id/users", to: "facilities#show_users", as: :show_facility_users
  get "/facilities/:id/patients", to: "facilities#show_patients", as: :show_facility_patients

  resources :visit_details
  resources :sessions
  resources :facilities
  resources :lsg_bodies
  resources :wards
  put "/users/:id/verify", to: "users#verify", as: :verify_user
  post "/users/custom", to: "users#create_custom", as: :create_custom_user
  put "/users/:id/verify", to: "users#verify", as: :verify_user
  devise_for :users, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                       passwords: "users/passwords",
                     }
  resources :users
end
