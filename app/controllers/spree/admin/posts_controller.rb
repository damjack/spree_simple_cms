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
      
      def destroy
        @post = Post.where(:permalink => params[:id]).first!
        @post.delete

        flash.notice = I18n.t('notice_messages.post_deleted')

        respond_with(@post) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end
      
      def published
        @post = Post.where(:permalink => params[:id]).first!
        @post.update_attribute(:published_at, Time.now)
        
        flash.notice = I18n.t('notice_messages.post_published')
        
        respond_with(@post) do |format|
          format.html { redirect_to collection_url }
        end
      end
      
      def unpublished
        @post = Post.where(:permalink => params[:id]).first!
        @post.update_attribute(:published_at, nil)
        
        flash.notice = I18n.t('notice_messages.post_unpublished')
        
        respond_with(@post) do |format|
          format.html { redirect_to collection_url }
        end
      end

      def clone
        @new = @post.duplicate

        if @new.save
          flash.notice = I18n.t('notice_messages.post_cloned')
        else
          flash.notice = I18n.t('notice_messages.post_not_cloned')
        end

        respond_with(@new) { |format| format.html { redirect_to edit_admin_post_url(@new) } }
      end

      protected
      def find_resource
        Spree::Post.find_by_permalink!(params[:id])
      end
      
      def location_after_save
        edit_admin_post_url(@post)
      end
      
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}

        params[:q][:s] ||= "name asc"
        
        if !params[:q][:published_at_gt].blank?
          params[:q][:published_at_gt] = Time.zone.parse(params[:q][:published_at_gt]).beginning_of_day rescue ""
        end

        if !params[:q][:published_at_lt].blank?
          params[:q][:published_at_lt] = Time.zone.parse(params[:q][:published_at_lt]).end_of_day rescue ""
        end

        @search = super.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(12)
      end
    end
  end
end