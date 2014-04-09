module Spree
  class TaxonomyPost < ActiveRecord::Base
    validates :name, :presence => true

    has_many :taxon_posts
    has_one :root, :conditions => { :parent_id => nil }, :class_name => "Spree::TaxonPost",
                   :dependent => :destroy

    after_save :set_name

    default_scope :order => "#{self.table_name}.position"

    private
      def set_name
        if root
          root.update_column(:name, name)
        else
          self.root = TaxonPost.create!({ :taxonomy_post_id => id, :name => name }, :without_protection => true)
        end
      end

  end
end
