module Spree
  module Admin
    class PostsController < ResourceController
      def index
        respond_with(@collection) do |format|
          format.html
          format.json { render :json => json_data }
        end
      end
      
      def show
        redirect_to( :action => :edit )
      end

      protected
      def location_after_save
        edit_admin_posts_url(@post)
      end
      
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}

        params[:q][:s] ||= "name asc"

        @search = super.ransack(params[:q])
        @collection = @search.result.
            published.
            page(params[:page]).
            per(Spree::Config[:admin_products_per_page])
      end
    end
  end
end