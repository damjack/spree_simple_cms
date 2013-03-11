class RefactorUploadAndBlog < ActiveRecord::Migration
  def change
    rename_column :spree_uploads, :attachment_name, :title
    rename_column :spree_uploads, :attachment_alt, :presentation
    add_column :spree_uploads, :permalink, :string, :after => :title
    add_column :spree_uploads, :type, :string, :after => :attachment_height
    change_column :spree_uploads, :presentation, :text
    
    add_column :spree_blogs, :publication_date_from, :date, :after => :to
    add_column :spree_blogs, :publication_date_to, :date, :after => :publication_date_from
  end
end
