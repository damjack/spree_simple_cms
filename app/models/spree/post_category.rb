module Spree
  class PostCategory < ActiveRecord::Base
    has_many :posts
    
    attr_accessible :name, :permalink, :tag_title, :meta_description, :meta_keywords, :description,
                    :icon, :position, :active, :published_at
    
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    
    make_permalink :order => :name    
    def to_param
      permalink.present? ? permalink : (permalink_was || name.to_s.to_url)
    end
  end
end