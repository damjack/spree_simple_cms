module Spree
  class Guide < Blog
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    
  end
end