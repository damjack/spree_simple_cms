module Spree
  class Page < ActiveRecord::Base
    has_and_belongs_to_many :products, :join_table => 'spree_pages_products'
    has_and_belongs_to_many :taxons, :join_table => 'spree_pages_taxons'
    has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    
    attr_accessible :title, :permalink, :tag_title, :meta_description, :meta_keywords, :body, :link,
                    :position, :in_nav_menu, :published_at
    
    accepts_nested_attributes_for :uploads, :allow_destroy => true
    
    make_permalink :order => :title
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end
    
    def link_is_blank?
      self.link.blank?
    end
  end 
end
