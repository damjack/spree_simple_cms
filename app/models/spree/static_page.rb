module Spree
  class StaticPage < Page
    belongs_to :product
    
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}") }
    
  end
end