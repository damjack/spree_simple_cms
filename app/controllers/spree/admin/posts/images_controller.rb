module Spree
  module Admin
    module Posts
      class ImagesController < ResourceController
        before_filter :load_data

        create.before :set_viewable
        update.before :set_viewable
        destroy.before :destroy_before

        private

        def location_after_save
          admin_post_images_url(@post)
        end

        def load_data
          @post = Spree::Post.find_by_permalink(params[:post_id])
          @posts = [@post.title, @post.id]
        end

        def set_viewable
          @image.viewable_type = 'Spree::Blog'
          @image.viewable_id = params[:image][:viewable_id]
        end

        def destroy_before
          @viewable = @image.viewable
        end

      end
    end
  end
end