module Spree
  class PostCategory < ActiveRecord::Base
    attr_accessible :title, :permalink, :tag_title, :meta_description, :meta_keywords, :presentation,
                    :position, :published_at
    
    make_permalink :order => :title
    has_and_belongs_to_many :posts, :join_table => 'spree_post_categories_posts', :uniq => true
    
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end    
  end
end