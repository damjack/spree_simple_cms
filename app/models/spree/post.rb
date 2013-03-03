module Spree
  class Post < Blog
    has_and_belongs_to_many :products, :join_table => 'spree_posts_products'
    has_and_belongs_to_many :taxons, :join_table => 'spree_posts_taxons'
    acts_as_commentable
    
    has_and_belongs_to_many :post_categories, :join_table => "spree_post_categories_posts", :class_name => "Spree::PostCategory"
    alias_attribute :categories, :post_categories
    
    attr_accessible :name, :content, :published_at, :active, :tag_list
    scope :published, lambda { where("published_at <= '#{Time.now}' AND active = 1") }
    scope :valid, lambda { where("from <= #{Time.now} AND to >= #{Time.now}") }
    
  end
end