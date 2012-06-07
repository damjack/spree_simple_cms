module Spree
  module Admin
    class BlogsController < ResourceController
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @blogs = @search.result.page(params[:name]).per(Spree::Config[:admin_products_per_page])
      end
      
      def collection
        @search = super.ransack(params[:search])
      end
      
      def new
          @blog = @object
      end

      def edit
          @blog = @object
      end

      def location_after_save
          admin_blogs_url
      end

    end
  end
end