DsInvest::Application.routes.draw do
  

  resources :saltydog_groups


  resources :sectors


  get "home/index"

  get "home/show_area"
  get "home/show_investment_sector"
  get "home/apply_filters"

  get "funds/set_fund_selection/:fund_id", to: "funds#set_fund_selection"
  get "funds/remove_fund_selection/:fund_id", to: "funds#remove_fund_selection"
  get "funds/find_funds"

  resources :time_points


  resources :countries do
    collection {post :import}
  end

  get "fund_records/downloads", to: 'fund_records#download', as: "fund_records/downloads"

    get "funds/downloads", to: 'funds#download', as: "funds/downloads"



  


  resources :funds


  get "show_last_file", to: 'file_stats#show_last', as: "show_last_file"

    get "file_already_loaded", to: 'file_stats#file_already_loaded', as: "file_already_loaded"

  resources :file_stats




  resources :fund_records do
    collection {post :import}
  end




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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
