module Spree
  class Page < ActiveRecord::Base
    has_and_belongs_to_many :products, :join_table => 'spree_pages_products'
    has_and_belongs_to_many :taxons, :join_table => 'spree_pages_taxons'
    has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    
    accepts_nested_attributes_for :uploads, :allow_destroy => true
    
    make_permalink :order => :title
    
    validates_presence_of :title
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end
    
    def published?
      !self.published_at.blank?
    end
    
    def self.retrive_by_taxon(taxon_id)
      Spree::Taxon.find(taxon_id).pages
    end

    def self.retrive_by_product(product_id)
      Spree::Product.find(product_id).pages
    end
    
    def link_is_blank?
      self.link.blank?
    end
  end 
end
