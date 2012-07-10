module Spree
  class Post < Blog
    #acts_as_commentable
    belongs_to :post_category
    attr_accessible :name, :content, :published_at, :active, :tag_list
    scope :published, lambda { where("published_at <= ? AND active = ?", Time.now, true) }
    scope :valid, lambda { where("from <= ? AND to >= ?", Time.now, Time.now) }
    
  end
end