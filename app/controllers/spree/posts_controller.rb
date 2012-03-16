module Spree
  class PostsController < BaseController
    before_filter :load_obj
        
    def load_obj
      @posts = Spree::Post.published
      if params[:path]
        @posts = Spree::Post.find(params[:path])
      end
    end
    
  end
end
