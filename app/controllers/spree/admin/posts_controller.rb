module Spree
  module Admin
    class PostsController < ResourceController
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @posts = @search.result.published.page(params[:name]).per(Spree::Config[:admin_products_per_page])
      end

      def collection
        @search = super.ransack(params[:search])
      end

      def new
        @post = @object
      end

      def edit
        @post = @object
      end
      
      protected
      def location_after_save
        admin_static_pages_url
      end
    end
  end
end