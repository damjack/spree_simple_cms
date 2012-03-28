Spree::Core::Engine.routes.draw do
  
  namespace :admin do
    resource :store_settings
    resources :blogs do
      resources :posts do
        collection do
          post :update_positions
        end
      end
    end
    resources :pages do
      collection do
        post :update_positions
      end
      resources :articles
      resources :static_pages do
        collection do
          post :update_positions
        end
      end
    end
    resources :uploads
  end
  
  resources :articles
  
  match '/contacts', :to => 'static_pages#contacts', :as => :contacts
  match '/contacts/send', :to => "static_pages#create_mail", :via => :post
  match '/pages/*id', :to => 'static_pages#show', :as => :page
  match '/pages', :to => 'static_pages#index', :as => :pages
  
  match '/post/*id', :to => 'posts#show', :as => :post
  match '/blog', :to => 'posts#index', :as => :posts

end
