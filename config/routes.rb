BestBay::Application.routes.draw do

 # devise_for :admins
  mount RailsAdmin::Engine => '/secret_admin', :as => 'rails_admin'

  devise_for :users, :controllers => { :registrations => "registrations" }

  match 'search' => 'items#search'
  match 'plans' => 'users#plans'
  match 'users/activate_type' => 'users#activate_type'
  match 'users/deactivate_type' => 'users#deactivate_type'
  match 'profile' => 'users#profile'

  # For mobile
  match 'api/users/:id/transactions' => 'transactions#index'
  match 'api/users/:id/bids' => 'bids#index'
  match 'api/users/:id/watch_list' => 'watch_lists#index'
  match 'api/users/check_id' => 'users#check_id'


  # match 'bids/:id/apply_to_cancel' => 'bids#apply_to_cancel'
  resources :items do 
    post 'apply_to_delete'
    post 'delete_item'
  end
  resources :users
  resources :bids, :except => [:index, :new] do
    post 'apply_to_cancel'
  end
  resources :billings
  # resources :user_types
  resources :watch_lists
  resources :transactions, :only => [ :create ]

  root :to => "home#index"
  # match ':controller(/:action(/:id))(.:format)'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
