module Spree
  class PostsController < BaseController
    before_filter :load_post, :only => :show
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/taxons'

    respond_to :html
    
    def show
      return unless @post
    end
    
    private
    def accurate_title
      @post ? @post.title : super
    end
    
    def load_post
      @post = Spree::Post.find_by_permalink!(params[:id])
    end
    
    before_filter :load_obj
    
    def show
      @post = Spree::Post.find_by_permalink(params[:id])
    end
    
    def load_obj
      @posts = Spree::Post.published.order('published_at desc')
    end
  end
end
