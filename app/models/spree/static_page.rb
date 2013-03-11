module Spree
  class StaticPage < Page
    belongs_to :product
    
    scope :published, lambda { where("published_at <= ? AND published_at IS NOT NULL", Time.now) }
    
    def initialize(*args)
      super(*args)
      last_static_page = StaticPage.last
      self.position = last_static_page ? last_static_page.position + 1 : 0
    end
    
  end
end