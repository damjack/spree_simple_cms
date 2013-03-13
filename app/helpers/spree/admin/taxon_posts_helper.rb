module Spree
  module Admin
    module TaxonPostsHelper
      def taxon_post_path(taxon_post)
        taxon_post.ancestors.reverse.collect { |ancestor| ancestor.name }.join( " >> ")
      end
    end
  end
end
