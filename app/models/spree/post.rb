module Spree
  class Post < Blog
    
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    scope :valid, lambda { where("from <= #{Time.now} AND to >= #{Time.now}") }
    
  end
end