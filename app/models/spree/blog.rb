module Spree
  class Blog < ActiveRecord::Base
    has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    
    attr_accessible :title, :permalink, :meta_description, :meta_keywords, :body, :link,
                    :position, :in_nav_menu, :published_at, :from, :to, :publication_date_from,
                    :publication_date_to, :tag_list
    
    acts_as_taggable
    acts_as_taggable_on :tags
    
    make_permalink :order => :title
    
    validates_presence_of :title
    
    accepts_nested_attributes_for :uploads, :allow_destroy => true
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end
    
    def published?
      !self.published_at.blank?
    end
    
    def check_date
      if from >=  to
        errors.add(:from, "non puo' essere maggiore uguale alla data di fine evento")
      end
      #if publication_date_from >= publication_date_to
      #  errors.add(:publication_date_from, "non puo' essere maggiore uguale alla data di fine pubblicazione")
      #end
    end
    
  end
end
