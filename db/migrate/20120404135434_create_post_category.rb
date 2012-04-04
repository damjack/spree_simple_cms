class CreatePostCategory < ActiveRecord::Migration
  def up
    create_table :spree_post_category do |t|
      
      t.string :name, :slug, :tag_title, :meta_description, :meta_keywords
      t.text :description
      
      t.string :icon_file_name, :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_update_at
      t.integer :icon_width, :icon_height
      
      t.integer :position
      
      t.boolean :active, :default => false
      t.datetime :published_at
      
      t.timestamps
    end
    add_index :spree_post_category, :slug, :unique => true
  end

  def down
    drop_table :spree_post_category
  end
end
