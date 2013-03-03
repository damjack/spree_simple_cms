Spree::Taxon.class_eval do
  has_and_belongs_to_many :pages, :join_table => 'spree_pages_taxons'
  
  def active_products
    scope = pages.published
    scope
  end
end