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

        #def location_after_save
        #   admin_posts_url
        #end

    end
  end
end