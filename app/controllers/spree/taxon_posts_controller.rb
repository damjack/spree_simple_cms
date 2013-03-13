module Spree
  class TaxonPostsController < Spree::StoreController
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/posts'

    respond_to :html

    def show
      @taxon_post = TaxonPost.find_by_permalink!(params[:id])
      return unless @taxon

      @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon_post.id))
      @products = @searcher.retrieve_posts

      respond_with(@taxon_post)
    end

    private
      def accurate_title
        @taxon_post ? @taxon_post.name : super
      end
  end
end
