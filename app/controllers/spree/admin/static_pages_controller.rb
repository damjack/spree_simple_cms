module Spree
  module Admin
    class StaticPagesController < ResourceController
      def index
        respond_with(@collection) do |format|
          format.html
          format.json { render :json => json_data }
        end
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      def destroy
        @static_page = StaticPage.where(:permalink => params[:id]).first!
        @static_page.delete

        flash.notice = I18n.t('notice_messages.post_deleted')

        respond_with(@static_page) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end

      def published
        @static_page = StaticPage.where(:permalink => params[:id]).first!
        @static_page.update_attribute(:published_at, Time.now)
        
        flash.notice = I18n.t('notice_messages.static_page_published')
        
        respond_with(@static_page) do |format|
          format.html { redirect_to collection_url }
        end
      end
      
      def unpublished
        @static_page = StaticPage.where(:permalink => params[:id]).first!
        @static_page.update_attribute(:published_at, nil)
        
        flash.notice = I18n.t('notice_messages.static_page_unpublished')
        
        respond_with(@static_page) do |format|
          format.html { redirect_to collection_url }
        end
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
          StaticPage.where(:id => id).update_all(:position => index)
        end

        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
      end

      protected
      def find_resource
        Spree::StaticPage.find_by_permalink!(params[:id])
      end
      
      def location_after_save
        edit_admin_static_page_url(@static_page)
      end
      
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}

        params[:q][:s] ||= "name asc"

        @search = super.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(12)
      end
    end
  end
end