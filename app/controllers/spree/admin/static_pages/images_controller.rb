module Spree
  module Admin
    module StaticPages
      class ImagesController < ResourceController
        before_filter :load_data

        create.before :set_viewable
        update.before :set_viewable
        destroy.before :destroy_before

        private

        def location_after_save
          admin_static_page_images_url(@static_page)
        end

        def load_data
          @static_page = Spree::StaticPage.find_by_permalink(params[:static_page_id])
          @static_pages = [@static_page.title, @static_page.id]
        end

        def set_viewable
          @image.viewable_type = 'Spree::Page'
          @image.viewable_id = params[:image][:viewable_id]
        end

        def destroy_before
          @viewable = @image.viewable
        end

      end
    end
  end
end