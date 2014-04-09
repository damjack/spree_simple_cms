Spree::Core::Engine.routes.draw do
  
  namespace :admin do
    resource :store_settings
    resources :posts do
      resources :images, :controller => 'posts/images' do
        post :update_positions, :on => :collection
      end
      post :update_positions, :on => :collection
      get :published, :on => :member
      get :unpublished, :on => :member
    end
    
    resources :static_pages do
      resources :images, :controller => 'static_pages/images' do
        post :update_positions, :on => :collection
      end
      post :update_positions, :on => :collection
      get :published, :on => :member
      get :unpublished, :on => :member
    end
    
    resources :uploads do
      post :update_positions, :on => :collection
    end
    
    resources :taxonomy_posts do
    	collection do
    		post :update_positions
    	end
      member do
        get :get_children
      end

      resources :taxon_posts
    end

    resources :taxon_posts, :only => [] do
      collection do
        get :search
      end
    end
  end
  
  get '/contacts', :to => 'static_pages#contacts', :as => :contacts
  post '/contacts/send', :to => "static_pages#create_mail"
  
  resources :static_pages
  resources :posts, :path => 'news'
    
  # route globbing for pretty nested taxon and product paths
  get '/tp/*id', :to => 'taxon_posts#show', :as => :nested_taxon_posts
end
