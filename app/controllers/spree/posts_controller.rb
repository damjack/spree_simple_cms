module Spree
  class PostsController < Spree::StoreController
    before_filter :load_page, :only => :show
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/taxons'
    
    respond_to :html
    
    def index
      if params[:tag]
        @posts = Spree::Post.published.tagged_with(params[:tag]).page(params[:page]).per(Spree::Config[:post_per_page]).order('published_at DESC')
      else
        @posts = Spree::Post.published.page(params[:page]).per(Spree::Config[:post_per_page]).order('published_at DESC')
      end
    end
    
    def show
      return unless @post
    end
    
    private
    def accurate_title
      @post ? @post.title : super
    end
    
    def load_page
      @post = Spree::Post.find_by_permalink!(params[:id])
    end
    
  end
end
