module Spree
  module Admin
    class TaxonomyPostsController < ResourceController
      respond_to :json, :only => [:get_children]

      def get_children
        @taxon_posts = TaxonPost.find(params[:parent_id]).children

        respond_with(@taxon_posts)
      end

      private

      def location_after_save
        if @taxonomy_post.created_at == @taxonomy_post.updated_at
          edit_admin_taxonomy_post_url(@taxonomy_post)
        else
          admin_taxonomy_posts_url
        end
      end
    end
  end
end
