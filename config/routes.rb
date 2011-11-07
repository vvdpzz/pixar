Pixar::Application.routes.draw do
  
  resources :questions do
    member do
      get :answers
      put :vote_for
      put :vote_against
      post :category_add
      post :category_del
      post :tag_add
      post :tag_del
    end
  end
  
  resources :answers, :only => [:create]
  
  resources :comments, :only => [:create]
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  # resources :messages do
  #   collection do
  #     get "load_conversations"
  #     post "send_message"
  #   end
  # end
  
  resources :messages do
    collection do
      get "load_conversations"
      get "load_contact_list"
      get "messages"
      get "load_messages"
      post "remove_conversation"
      post "send_message"
      get "load_messages_on_navbar"
      post "update_last_viewed"
    end
  end
  
  resources :notifications do
    collection do
      get "load_notifications"
      post "set_all_seen"
    end
  end

  devise_for :users
  resources :users
  resources :recharge do
    collection do
      post :notify
      get :done
      post :generate_order
    end
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
  root :to => 'questions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
