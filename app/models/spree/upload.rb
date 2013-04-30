module Spree
  class Upload < ActiveRecord::Base
    belongs_to :uploadable, :polymorphic => true
    acts_as_list
    
    attr_accessible :position, :title, :presentation, :attachment, :permalink
    
    make_permalink :order => :title
    
    has_attached_file :attachment,
                      :url => '/spree/uploads/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/uploads/:id/:style/:basename.:extension'
    
    include Spree::Core::S3Support
    supports_s3 :attachment
    
    def to_param
      permalink.present? ? permalink : (permalink_was || title.to_s.to_url)
    end
  end
end