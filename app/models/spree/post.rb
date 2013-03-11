module Spree
  class Post < Blog
    #acts_as_commentable
    belongs_to :post_category
    scope :published, lambda { where("published_at <= '#{Time.now}' AND active = 1") }
    scope :valid, lambda { where("from <= #{Time.now} AND to >= #{Time.now}") }
    
  end
end