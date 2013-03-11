module Spree
  module Admin
    class StaticPagesController < ResourceController
      before_filter :load_data, :except => :index
      
      def index
        respond_with(@collection)
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      def destroy
        @static_page = Spree::StaticPage.where(:permalink => params[:id]).first!
        @static_page.delete

        flash.notice = I18n.t('notice_messages.page_deleted')

        respond_with(@static_page) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end
      
      def published
        @static_page = Spree::StaticPage.where(:permalink => params[:id]).first!
        @static_page.update_attribute(:published_at, Time.now)
        
        flash[:notice] = t("notice_messages.page_published")
        
        respond_with(@static_page) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end
      
      def unpublished
        @static_page = Spree::StaticPage.where(:permalink => params[:id]).first!
        @static_page.update_attribute(:published_at, nil)
        
        flash[:notice] = t("notice_messages.page_unpublished")
        
        respond_with(@static_page) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end

      def in_nav_menu
        @static_page = Spree::StaticPage.where(:permalink => params[:id]).first!

        if @static_page.update_attribute(:in_nav_menu, true)
          flash[:notice] = t("info_in_nav_menu_static_page")
        else
          flash[:error] = t("error_in_nav_menu_static_page")
        end
        redirect_to spree.admin_static_pages_path
      end
      
      protected
      def find_resource
        Spree::StaticPage.find_by_permalink!(params[:id])
      end
      
      def location_after_save
         edit_admin_static_page_url(@static_page)
      end
      
      def load_data
        @taxons = Taxon.order(:name)
        @products = Product.order(:name)
      end
      
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}
        params[:q][:s] ||= "title asc"
        
        @search = super.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_post_per_page])
      end
      
    end
  end
end