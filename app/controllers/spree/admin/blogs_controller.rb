module Spree
  module Admin
    class BlogsController < ResourceController
      def index
        respond_with(@collection) do |format|
          format.html
          format.json { render :json => json_data }
        end
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      def collection
        return @collection if @collection.present?

        unless request.xhr?
          params[:search] ||= {}

          params[:search][:meta_sort] ||= "name.asc"
          @search = super.metasearch(params[:search])

          @collection = @search.relation.page(params[:name]).per(Spree::Config[:admin_products_per_page])
        else
          @collection = super.where(["name #{LIKE} ?", "%#{params[:q]}%"])
          @collection = @collection.limit(params[:limit] || 10)
        end
      end

      protected
      def location_after_save
          admin_blogs_url()
      end
    end
  end
end