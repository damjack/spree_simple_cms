class RefactorTables < ActiveRecord::Migration
  def change
    remove_index :spree_pages, :slug
    rename_column :spree_pages, :slug, :permalink
    remove_index :spree_blogs, :slug
    rename_column :spree_blogs, :slug, :permalink
    
    add_index :spree_pages, :permalink, :unique => true
    add_index :spree_blogs, :permalink, :unique => true
    
    remove_column :spree_pages, :tag_title
    remove_column :spree_blogs, :tag_title
    
    rename_column :spree_pages, :image_file_name, :attachment_file_name
    rename_column :spree_pages, :image_content_type, :attachment_content_type
    rename_column :spree_pages, :image_file_size, :attachment_file_size
    rename_column :spree_pages, :image_update_at, :attachment_update_at
    rename_column :spree_pages, :image_width, :attachment_width
    rename_column :spree_pages, :image_height, :attachment_height
    
    rename_column :spree_blogs, :image_file_name, :attachment_file_name
    rename_column :spree_blogs, :image_content_type, :attachment_content_type
    rename_column :spree_blogs, :image_file_size, :attachment_file_size
    rename_column :spree_blogs, :image_update_at, :attachment_update_at
    rename_column :spree_blogs, :image_width, :attachment_width
    rename_column :spree_blogs, :image_height, :attachment_height
    
    remove_index :spree_post_category, :slug
    rename_column :spree_post_category, :slug, :permalink
    add_index :spree_post_category, :permalink, :unique => true
  end
end
