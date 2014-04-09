module Spree
  class Blog < ActiveRecord::Base
    has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
    has_many :uploads, :as => :uploadable
    
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
