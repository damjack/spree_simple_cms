module Spree
  class Post < Blog
    #acts_as_commentable
    
    has_and_belongs_to_many :post_categories, :join_table => "spree_post_categories_posts", :class_name => "Spree::PostCategory"
    alias_attribute :categories, :post_categories
    
    scope :published, lambda { where("published_at <= '#{Time.now}' AND active = 1") }
    scope :valid, lambda { where("from <= #{Time.now} AND to >= #{Time.now}") }
    
  end
end