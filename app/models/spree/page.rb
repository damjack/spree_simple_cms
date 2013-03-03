module Spree
  class Page < ActiveRecord::Base
    attr_accessible :title, :permalink, :tag_title, :meta_description, :meta_keywords, :body, :link,
                    :position, :in_nav_menu, :published_at
    
    has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
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
