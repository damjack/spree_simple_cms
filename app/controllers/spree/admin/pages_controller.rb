module Spree
  module Admin
    class PagesController < ResourceController      
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @pages = @search.page(params[:name]).per(Spree::Config[:admin_products_per_page])
      end
      
      def collection
        @search = super.metasearch(params[:search])
      end
      
      def new
          @page = @object
      end

      def edit
          @page = @object
      end
    end
  end
end