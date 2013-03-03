module Spree
  class Blog < ActiveRecord::Base
    has_many :blog_images, :source => :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    
    attr_accessible :title, :permalink, :tag_title, :meta_description, :meta_keywords, :description, :content, :link,
                    :position, :in_nav_menu, :published_at
    # TAGGING AND COMMENT SYSTEM
    acts_as_taggable
    acts_as_taggable_on :tags
    
    make_permalink :order => :title
    
    validates_presence_of :title, :content
    
    has_many :products, :through => :post_products
    has_many :blog_images, :source => :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    accepts_nested_attributes_for :uploads, :allow_destroy => true

    before_save :set_published_at, :if => Proc.new {|model| model.published_at.nil? }
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end
    
    def set_published_at
      self.published_at = Time.now
    end    
  end
end
