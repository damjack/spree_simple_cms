module Spree
  class PostCategory < ActiveRecord::Base
    attr_accessible :name, :tag_title, :meta_description, :meta_keywords, :description, :icon,
                    :active, :slug, :position, :published_at
    
    extend ::FriendlyId
    friendly_id :name, :use => :slugged
    has_many :posts
    
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    
  end
end