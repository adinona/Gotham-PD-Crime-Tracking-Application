Rails.application.routes.draw do

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/dashboard', to: 'home#dashboard', as: :dashboard

  # Authentication routes
  resources :users
  resources :sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout



  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :officers
  resources :units
  resources :investigations
  resources :crimes
  resources :criminals
  resources :investigation_notes
  resources :crime_investigations


  # Routes for assignments
  get 'assignments/new', to: 'assignments#new', as: :new_assignment
  post 'assignments', to: 'assignments#create', as: :assignments
  patch 'assignments/:id/terminate', to: 'assignments#terminate', as: :terminate_assignment

  # Routes for suspects

  get 'suspects/new', to: 'suspects#new', as: :new_suspect
  post 'suspects', to: 'suspects#create', as: :suspects
  patch 'suspects/:id/terminate', to: 'suspects#terminate', as: :terminate_suspect


  # Routes for investigation

  patch 'investigations/:id/terminate', to: 'investigations#terminate', as: :terminate_investigation


  # Toggle paths




  # Other custom routes

  # Routes for searching
  get 'officers_search', to: 'officers#search', as: :officer_search
  get 'criminals_search', to: 'criminals#search', as: :criminal_search
  get 'investigations_search', to: 'investigations#search', as: :investigation_search



  # You can have the root of your site routed with 'root'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
