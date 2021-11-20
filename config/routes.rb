Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    root 'home#index'

  # Public change log
  scope "changelog", as: "changelog", controller: "changelog" do
    get "(/:year)", action: "index"
  end

  # Sidebar Links
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/search", to: "search#index"

  #Schedule
  get "/schedule", to: "schedule#index", as: :schedule
  post "/schedule", to: "schedule#schedule"
  delete "/schedule", to: "schedule#unschedule"
  get '/agenda', to: 'agenda#index', as: :agenda

  # patients
  resources :patients do

    # patient's disease history
    get "/disease_history",
        to: "patient_disease_summaries#index",
        as: :disease_history
    put "/patient_disease_summary/", to: "patient_disease_summaries#update"

    # patient's family details
    get "/family_details", to: "family_details#index", as: :family_details
    put "/family_details/", to: "family_details#update"

    #treatment
    get '/treatment', to: 'treatment#new'
    post '/treatment/', to: 'treatment#update'
    put 'treatment/stop_treatment', to: 'treatment#stop_treatment'

    # view patient's complete information
    get "/show/family_details",
        to: "patients#show_detail",
        as: :show_family_details
    get "/show/personal_details",
        to: "patients#show_detail",
        as: :show_personal_details
    get "/show/disease_history",
        to: "patients#show_detail",
        as: :show_disease_history
    get '/show/treatment_history',
        to: 'patients#show_detail',
        as: :show_treatment_history

    # visit_details

    get '/visit_details/decision', to: 'visit_details#decision'
    post '/visit_details/assign_to', to: 'visit_details#assign_to'
    post '/visit_details/schedule_revisit', to: 'visit_details#schedule_revisit'
    post '/visit_details/expired', to: 'visit_details#expired'
    get '/visit_details/new', to: 'visit_details#new', as: :visit_details_new
    get '/visit_details/:visit_id/general_health_information',to: "general_health_informations#new", as: :visit_general_information
    post '/visit_details/:visit_id/general_health_information',to: "general_health_informations#create", as: :new_visit_general_information

    get '/visit_details/:visit_id/psychological_review',to: "psychological_reviews#new", as: :visit_psychological_review
    post '/visit_details/:visit_id/psychological_review',to: "psychological_reviews#create", as: :new_visit_psychological_review

    get '/visit_details/:visit_id/physical_symptom',to: "physical_symptoms#new", as: :visit_physical_symptom
    post '/visit_details/:visit_id/physical_symptom',to: "physical_symptoms#create", as: :new_visit_physical_symptom

    get '/visit_details/:visit_id/physical_examination',to: "physical_examinations#new", as: :visit_physical_examination
    post '/visit_details/:visit_id/physical_examination',to: "physical_examinations#create", as: :new_visit_physical_examination
    resources :visit_details
  end



  #Sessions
  resources :sessions
  get 'logout', to: 'sessions#logout'

  # Facilities
  resources :facilities
  get 'facilities/get_districts_of_state/:state_id',
      to: 'facilities#get_districts_of_state'
  get 'facilities/get_wards_of_lsg_body/:lsg_body_id',
      to: 'facilities#get_wards_of_lsg_body'


  # get users belonging to a facility
  get '/facilities/:id/users',
      to: 'facilities#show_users',
      as: :show_facility_users
  get '/facilities/:id/patients',
      to: 'facilities#show_patients',
      as: :show_facility_patients

  resources :lsg_bodies
  resources :wards

  # Users

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
  }

  scope :admin do
    put "/users/:id/verify", to: "users#verify", as: :verify_user

    get '/signup', to: 'users#signup', as: :signup

    get '/password_reset', to: 'password_reset#index', as: 'password_reset_page'
    post '/password_reset/send_otp', to: 'password_reset#send_otp'
    post '/password_reset/verify', to: 'password_reset#verify'
    post '/password_reset/update', to: 'password_reset#update'
    resources :users

    # get '/stories', to: redirect('/articles')

    # for assigning a nurse to a facility
    put '/assign', to: 'users#assign_facility', as: :assign_facility

    # for removing a nurse from a facility
    put '/unassign', to: 'users#unassign_facility', as: :unassign_facility

  end
end
