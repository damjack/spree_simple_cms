module Spree
  module Admin
    class StaticPagesController < ResourceController
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @static_pages = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
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
          format.js { render :text => 'Ok' }
        end
      end

      def collection
        @search = super.ransack(params[:search])
      end

      def new
        @static_page = @object
      end

      def edit
        @static_page = @object
      end

=begin
  TODO da togliere: sarebbe preferibile lasciare :
       def location_after_save
           admin_static_pages_url
       end
  e togliere:
    - def update
    - def create
=end

        def update
          invoke_callbacks(:update, :before)
          if @object.update_attributes(params[object_name])
            invoke_callbacks(:update, :after)
            flash.notice = flash_message_for(@object, :successfully_updated)
            redirect_to location_after_save
            #respond_with(@object) do |format|
            #  format.html { redirect_to self.location_after_save }
            #  format.js   { render :layout => false }
            #end
          else
            invoke_callbacks(:update, :fails)
            respond_with(@object)
          end
        end

        def create
          invoke_callbacks(:create, :before)
          if @object.save
            invoke_callbacks(:create, :after)
            flash.notice = flash_message_for(@object, :successfully_created)
            redirect_to location_after_save
            #respond_with(@object) do |format|
            #  format.html { redirect_to location_after_save }
            #  format.js   { render :layout => false }
            #end
          else
            invoke_callbacks(:create, :fails)
            respond_with(@object)
          end
        end


      protected

        def location_after_save
           admin_static_pages_url
        end


    end
  end
end