module Spree
  class Post < Blog
    has_and_belongs_to_many :products, :join_table => 'spree_posts_products'
    has_and_belongs_to_many :taxons, :join_table => 'spree_posts_taxons'
    acts_as_commentable
    
    has_and_belongs_to_many :taxon_posts, :join_table => "spree_posts_taxon_posts", :class_name => "Spree::TaxonPost"
    
    attr_accessible :taxon_ids, :product_ids
    
    scope :published, lambda { where("published_at <= '#{Time.now}' AND active = 1") }
    scope :valid, lambda { where("from <= #{Time.now} AND to >= #{Time.now}") }
    
  end
end