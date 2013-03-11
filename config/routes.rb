Spree::Core::Engine.routes.draw do
  
  namespace :admin do
    resource :store_settings

    resources :posts do
      collection do
        post :update_positions
      end
      member do
        get :published
        get :unpublished
      end
    end
    
    resources :static_pages do
      collection do
        post :update_positions
      end
      member do
        get :published
        get :in_nav_menu
      end
    end
    resources :uploads
  end
  
  match '/contacts', :to => 'static_pages#contacts', :as => :contacts
  match '/contacts/send', :to => "static_pages#create_mail", :via => :post
  match '/pages/:id', :to => 'static_pages#show', :as => :page
  match '/pages', :to => 'static_pages#index', :as => :pages
  
  match '/news', :to => 'posts#index', :as => :posts
  match '/news/:id', :to => 'posts#show', :as => :post

end
