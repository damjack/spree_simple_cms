class RefactorTables < ActiveRecord::Migration
  def change
    # Remove slug, added permalink and rename name => title
    remove_index :spree_pages, :slug
    rename_column :spree_pages, :slug, :permalink
    rename_column :spree_pages, :name, :title
    add_index :spree_pages, :permalink, :unique => true
    remove_index :spree_blogs, :slug
    rename_column :spree_blogs, :slug, :permalink
    rename_column :spree_blogs, :name, :title
    add_index :spree_blogs, :permalink, :unique => true
    
    # Remove all image attachment for model
    remove_column :spree_pages, :image_file_name
    remove_column :spree_pages, :image_content_type
    remove_column :spree_pages, :image_file_size
    remove_column :spree_pages, :image_update_at
    remove_column :spree_pages, :image_width
    remove_column :spree_pages, :image_height
    remove_column :spree_blogs, :image_file_name
    remove_column :spree_blogs, :image_content_type
    remove_column :spree_blogs, :image_file_size
    remove_column :spree_blogs, :image_update_at
    remove_column :spree_blogs, :image_width
    remove_column :spree_blogs, :image_height
    
    remove_column :spree_pages, :description
    rename_column :spree_pages, :content, :body
    remove_column :spree_blogs, :description
    rename_column :spree_blogs, :content, :body
    
    # Remove slug, added permalink and rename name => title for category
    remove_index :spree_post_category, :slug
    rename_column :spree_post_category, :slug, :permalink
    rename_column :spree_post_category, :name, :title
    add_index :spree_post_category, :permalink, :unique => true
    rename_column :spree_post_category, :description, :presentation
  end
end
