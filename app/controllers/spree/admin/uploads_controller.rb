module Spree
  module Admin
    class UploadsController < ResourceController
      def index
        respond_with(@collection)
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      def destroy
        @upload = Spree::Upload.where(:permalink => params[:id]).first!
        @upload.delete

        flash.notice = I18n.t('notice_messages.upload_deleted')

        respond_with(@upload) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end
      
      protected
      def find_resource
        Spree::Upload.find_by_permalink!(params[:id])
      end
      
      def location_after_save
        edit_admin_upload_url(@upload)
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