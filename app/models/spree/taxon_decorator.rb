Spree::Taxon.class_eval do
  has_and_belongs_to_many :pages, :join_table => 'spree_pages_taxons'
  has_and_belongs_to_many :posts, :join_table => 'spree_posts_taxons'
  
  def active_pages
    scope = pages.published
    scope
  end
  
  def active_posts
    scope = posts.published
    scope
  end
end