module Spree
  class PostsController < BaseController
    before_filter :load_obj
    
    def show
      @posts = Spree::Blog.find(params[:id])
    end
    
    def load_obj
      @posts = Spree::Post.published
    end
    
  end
end
