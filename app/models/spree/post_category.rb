module Spree
  class PostCategory < ActiveRecord::Base
    extend ::FriendlyId
    friendly_id :name, :use => :slugged
    has_many :posts
    
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    
  end
end