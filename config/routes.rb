Wpcc::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  resources :postal_codes

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  #connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority
  #connect ':controller/:action/:id.:format'
  #connect ':controller/:action/:id'

  get "password_resets/new"

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  resources :request_access



  resources :notes
  resources :note

  match 'user/sucess' => 'users#sucess', :as => :sucess_user

  match '/users/request_access', :to => "users#request_access", as: 'request_access_verification'

  match '/product_instances/request_initial', :to => "product_instances#request_initial", as: 'request_initial_verification'

  match '/product_instance/pi_same_as_above', :to => 'product_instance#copy_pi_address_to_client', :as => :pi_same_as_above

  match '/product_key/validate_key', :to => "product_key#validate_key", :as => :validate_key
  match '/product_key/post_validate_key', :to => "product_key#post_validate_key", :as => :post_validate_key
  match '/product_instances/create_client', :to => "product_instances#create_client", :defaults => { :format => 'js' }
  match '/product_instances/create_user', :to => "product_instances#create_user"

  match "users/email_confirmation", :to => "users#email_confirmation"
  match "users/send_confirmation_email", :to => "users#send_confirmation_email", :as => :send_confirmation_email

  #update product instance methods
  match '/product_instances/{id}/authorize_user', :to => "product_instances#/{id}/authorize_user", :as => :authorize_user

  match 'users/current_user_request_access', :to => "users#current_user_request_access", :as => :current_user_request_access
  match 'users/grant_access', :to => "users#grant_access", :as => :grant_user_access

  match 'product_instances/notify_signator', :to => 'product_instances#notify_signator', :as => :notify_signator
  match 'product_instances/manage_access/:id' => 'product_instances#manage_access', :as => :manage_access

  resources :users
  resources :product_instances


  # Nested routes for product_types and product_instances
  resources :product_types do
    resources :product_instances do
      resources :components
    end
  end



  #Nested routes for countries, states and cities
  resources :countries do
    match '/countries/:country_name', :to => "countries#show", :as => :country_states_ajax
  end

  resources :product_types
  resources :city

  resources :attachments

  resources :languages

  resources :component_types

  resources :element_types
  resources :element_values

  resources :form_instances
  resources :form_instance_versions
  resources :components
  resources :formplates
  resources :forms

  resources :clients

  resources :address

  resources :products


  resources :product_keys
  resources :product_key
  resources :news_letters, only: [:create]
  match 'update_language' => 'static_pages#update_language', :as => :update_language_static_pages


  root to: 'sessions#new'

  match '/about', to:  'static_pages#about'
  match '/works', to: 'static_pages#how_it_works'

  match '/contact', to: 'static_pages#contact'

  match '/signup', to: 'product_key#validate_key'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
end
