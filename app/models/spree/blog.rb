module Spree
  class Blog < ActiveRecord::Base
    attr_accessible :title, :permalink, :tag_title, :meta_description, :meta_keywords, :active,
                    :body, :link, :position, :in_nav_menu, :published_at, :tag_list
    # TAGGING AND COMMENT SYSTEM
    acts_as_taggable
    acts_as_taggable_on :tags
    
    make_permalink :order => :title
    
    validates_presence_of :title, :body
    
    has_many :products, :through => :post_products
    has_many :blog_images, :source => :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    accepts_nested_attributes_for :uploads, :allow_destroy => true
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end
  end
end
