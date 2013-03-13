class CreateTaxonomyPost < ActiveRecord::Migration
  def change
    create_table :spree_taxonomy_posts do |t|
      t.string :name
      t.integer :position
      
      t.timestamps
    end
  end
end
