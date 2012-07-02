module Spree
  class StaticPage < Page
    belongs_to :product
    
    attr_accessible :name, :slug, :tag_title, :meta_description, :meta_keywords, :content, :published_at, :image_width, :image_height
    scope :published, lambda { where("published_at <= ? AND published_at IS NOT NULL", Time.now) }
    
    def initialize(*args)
      super(*args)
      last_static_page = StaticPage.last
      self.position = last_static_page ? last_static_page.position + 1 : 0
    end
    
    def published?
      !self.published_at.blank?
    end
    
  end
end