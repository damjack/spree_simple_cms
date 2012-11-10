module Spree
  class Page < ActiveRecord::Base    
    extend ::FriendlyId
    friendly_id :name, :use => :slugged
    
    has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
    
    def should_generate_new_friendly_id?
      new_record?
    end

    def link_is_blank
      self.link.blank?
    end

    def content_is_blank
      self.content.blank?
    end    
  end 
end
