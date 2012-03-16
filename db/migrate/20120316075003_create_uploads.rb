class CreateUploads < ActiveRecord::Migration
  def change
    create_table :spree_uploads do |t|
      
      t.string :attachment_name
      t.string :attachment_alt
      
      t.string :attachment_content_type, :attachment_file_name
      t.integer :attachment_size
      t.string :type, :limit => 75
      t.integer :attachment_width, :attachment_height
      
      t.integer :position
      
      t.references :uploadable, :polymorphic => true
      
      t.timestamps
    end
  end
end
