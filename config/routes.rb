Spree::Core::Engine.routes.draw do
  
  namespace :admin do
    resources :blogs do
      resources :posts
    end
    resources :pages do
      resources :articles
      resources :static_pages
    end
    resources :uploads
  end
  
  resources :articles
  
  match '/contacts', :to => 'static_pages#contacts', :as => :contacts
  match '/pages/*path', :to => 'static_pages#show', :as => :page
  match '/pages', :to => 'static_pages#index', :as => :pages
  
  match '/post/*path', :to => 'posts#show', :as => :post
  match '/blog', :to => 'posts#index', :as => :posts

end
