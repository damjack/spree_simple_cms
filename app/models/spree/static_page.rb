module Spree
  class StaticPage < Page
    belongs_to :product
    
    scope :published, lambda { where("published_at <= ? AND published_at IS NOT NULL", Time.now) }
    
    def published?
      !self.published_at.blank?
    end
  end
end