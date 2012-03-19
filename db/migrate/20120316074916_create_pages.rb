class CreatePages < ActiveRecord::Migration
  def change
    create_table :spree_pages do |t|
      
      t.string :name, :slug, :tag_title, :meta_description, :meta_keywords
      t.text :description, :limit => 500
      t.text :content
      t.string :link
      
      t.string :type
      
      t.string :image_file_name, :image_content_type
      t.integer :image_file_size
      t.datetime :image_update_at
      t.integer :image_width, :image_height
      
      t.datetime :published_at
      
      t.references :product
      
      t.timestamps
    end
    add_index :spree_pages, :slug, :unique => true
  end
end
