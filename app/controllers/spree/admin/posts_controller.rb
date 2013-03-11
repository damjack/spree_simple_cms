module Spree
  module Admin
    class PostsController < ResourceController
      before_filter :load_data, :except => :index
      
      def index
        respond_with(@collection)
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      def destroy
        @post = Spree::Post.where(:permalink => params[:id]).first!
        @post.delete

        flash.notice = I18n.t('notice_messages.post_deleted')

        respond_with(@post) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end
      
      protected
      def find_resource
        Spree::Post.find_by_permalink!(params[:id])
      end
      
      def location_after_save
        edit_admin_post_url(@post)
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