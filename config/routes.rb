Ddi3::Application.routes.draw do
  resources :question_grids

  resources :response_units

  resources :instances

  resources :cc_ifthenelses

  resources :cc_loops

  resources :cc_alls

  resources :cc_sequences

  resources :cc_statements

  get "universe/index"

  get "universe/show"

  get "universe/new"

  get "universe/edit"

  resources :cc_questions
  resources :universes
  resources :question_items
  resources :response_domain_numerics
  resources :response_domain_codes
  resources :response_domain_datetimes
  resources :response_domain_texts
  resources :code_schemes do
    resources :codes
  end
  resources :categories do
    resources :codes
    get :auto_complete_search, :on => :collection
  end
  get "home/index"

  #added manually
  match 'spine' => 'cc_alls#spine', :as => 'spine'
  #match 'ddi3instance' => 'instances#show', :id => 1, :format => 'xml', :as => 'ddi3instance'
  
  # id not needed because .first is called and it no longer depends on the value of the index
  #match 'ddi3instance' => 'instances#show', :id => 1, :as => 'ddi3instance'
  #match 'ddi3instance/xml' => 'instances#ddi3', :id => 1, :format => 'xml', :as => 'ddi3instance_xml'
  #match 'ddi3instance/edit' => 'instances#edit', :id => 1, :as => 'ddi3instance_edit'

  match 'ddi3instance' => 'instances#show', :as => 'ddi3instance'
  match 'ddi3instance/xmlclean' => 'instances#ddi3clean', :format => 'xml', :as => 'ddi3instance_xmlclean'
  match 'ddi3instance/xml' => 'instances#ddi3', :format => 'xml', :as => 'ddi3instance_xml'
  match 'ddi3instance/edit' => 'instances#edit', :as => 'ddi3instance_edit'
  match 'ddi3instance/stats' => 'instances#stats', :as => 'ddi3instance_stats'
  match 'ddi3instance/qlist' => 'instances#qlist', :format => 'txt', :as => 'ddi3instance_qlist'
  match 'ddi3instance/doc' => 'instances#doc', :as => 'ddi3instance_doc'
  
  resources :question_items do
    get :auto_complete_search, :on => :collection
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
    root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
