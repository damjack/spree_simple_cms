module Spree
  module Admin
    class StaticPagesController < ResourceController      
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @static_pages = @search.page(params[:name]).per(Spree::Config[:admin_products_per_page])
      end
      
      def published
        sp = Spree::StaticPage.find(params[:id])

        if sp.update_attribute(:published_at, Time.now)
           flash[:notice] = t("info_published_static_page")
        else
           flash[:error] = t("error_published_static_page")
        end
        redirect_to spree.admin_static_pages_path
      end
      
      def in_nav_menu
        sp = Spree::StaticPage.find(params[:id])

        if sp.update_attribute(:in_nav_menu, true)
           flash[:notice] = t("info_in_nav_menu_static_page")
        else
           flash[:error] = t("error_in_nav_menu_static_page")
        end
        redirect_to spree.admin_static_pages_path
      end
      
      def update_positions
        params[:positions].each do |id, index|
          Spree::StaticPage.update_all(['position=?', index], ['id=?', id])
        end

        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
      end
      
      def collection
        @search = super.metasearch(params[:search])
      end
      
      def new
          @static_page = @object
      end

      def edit
          @static_page = @object
      end
    end
  end
end