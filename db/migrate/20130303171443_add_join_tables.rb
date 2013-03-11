class AddJoinTables < ActiveRecord::Migration
  def change
    create_table :spree_pages_products, :id => false do |t|
      t.references :page
      t.references :product
    end

    add_index :spree_pages_products, [:page_id], :name => 'index_spree_pages_products_on_page_id'
    add_index :spree_pages_products, [:product_id],   :name => 'index_spree_pages_products_on_product_id'
    
    create_table :spree_posts_products, :id => false do |t|
      t.references :post
      t.references :product
    end

    add_index :spree_posts_products, [:post_id], :name => 'index_spree_posts_products_on_post_id'
    add_index :spree_posts_products, [:product_id],   :name => 'index_spree_posts_products_on_product_id'
    
    create_table :spree_pages_taxons, :id => false do |t|
      t.references :page
      t.references :taxon
    end

    add_index :spree_pages_taxons, [:page_id], :name => 'index_spree_pages_taxons_on_page_id'
    add_index :spree_pages_taxons, [:taxon_id],   :name => 'index_spree_pages_taxons_on_taxon_id'
    
    create_table :spree_posts_taxons, :id => false do |t|
      t.references :post
      t.references :taxon
    end

    add_index :spree_posts_taxons, [:post_id], :name => 'index_spree_posts_taxons_on_post_id'
    add_index :spree_posts_taxons, [:taxon_id],   :name => 'index_spree_posts_taxons_on_taxon_id'
  end
end
