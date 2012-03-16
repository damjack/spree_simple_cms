module Spree
  module Admin
    class UploadsController < ResourceController
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @uploads = @search.page(params[:attachment_name]).per(Spree::Config[:admin_products_per_page])
      end
      
      def collection
        @search = super.metasearch(params[:search])
      end
      
      def new
          @upload = @object
      end

      def edit
          @upload = @object
      end
    end
  end
end