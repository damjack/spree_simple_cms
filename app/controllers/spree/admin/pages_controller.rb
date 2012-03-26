module Spree
  module Admin
    class PagesController < ResourceController      
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @pages = @search.page(params[:name]).per(Spree::Config[:admin_products_per_page])
      end
      
      def update_positions
        params[:positions].each do |id, index|
          Spree::Page.update_all(['position=?', index], ['id=?', id])
        end

        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
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