module Spree
  class StaticPage < Page 
    scope :published, lambda { where("published_at <= ? AND published_at IS NOT NULL", Time.now) }
    
  end
end