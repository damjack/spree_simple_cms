class RefactorPostCategory < ActiveRecord::Migration
  def change
    remove_column :spree_pages, :tag_title
    remove_column :spree_blogs, :tag_title
    remove_column :spree_post_category, :tag_title
    remove_column :spree_post_category, :active
    remove_column :spree_post_category, :icon_height
    remove_column :spree_post_category, :icon_width
    
    rename_table :spree_post_category, :spree_taxon_posts
    
    rename_column :spree_taxon_posts, :title, :name
    add_index :spree_taxon_posts, :permalink, :unique => true
    rename_column :spree_taxon_posts, :presentation, :description
    add_column :spree_taxon_posts, :parent_id, :integer, :after => :id
    add_column :spree_taxon_posts, :taxonomy_post_id, :integer, :after => :permalink
    add_column :spree_taxon_posts, :lft, :integer, :after => :taxonomy_post_id
    add_column :spree_taxon_posts, :rgt, :integer, :after => :lft
    
    create_table :spree_posts_taxon_posts, :id => false do |t|
      t.references :post
      t.references :taxon_post
    end

    add_index :spree_posts_taxon_posts, [:post_id], :name => 'index_spree_posts_taxon_posts_on_pt_id'
    add_index :spree_posts_taxon_posts, [:taxon_post_id],   :name => 'index_spree_posts_taxon_posts_on_p_id'
  end
end
