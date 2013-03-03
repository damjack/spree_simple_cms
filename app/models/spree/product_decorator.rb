Spree::Product.class_eval do
  has_and_belongs_to_many :static_pages, :join_table => 'spree_pages_products'
  has_and_belongs_to_many :posts, :join_table => 'spree_posts_products'
end