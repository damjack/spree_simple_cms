module Spree
  class PostsController < BaseController
    before_filter :load_obj
    
    def show
      @post = Spree::Blog.find(params[:id])
    end
    
    def load_obj
      @posts = Spree::Post.published.order('published_at desc')
    end

    def index
      if params[:tag]
        @posts = @posts.tagged_with(params[:tag]).page(params[:page]).per(Spree::Config.post_per_page)
      else
        @posts = @posts.page(params[:page]).per(Spree::Config.post_per_page)
      end
    end

  end
end
