module Spree
  class TaxonPost < ActiveRecord::Base
    acts_as_nested_set :dependent => :destroy
    
    belongs_to :taxonomy_post
    has_and_belongs_to_many :posts, :join_table => 'spree_posts_taxon_posts'
    
    before_create :set_permalink
    
    attr_accessible :name, :parent_id, :position, :icon, :description, :permalink, :taxonomy_id,
                    :published_at, :meta_description, :meta_keywords
    
    validates :name, :presence => true

    has_attached_file :icon,
                      :styles => { :mini => '32x32>', :normal => '128x128>' },
                      :default_style => :mini,
                      :url => '/spree/taxon_posts/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/taxon_posts/:id/:style/:basename.:extension',
                      :default_url => '/assets/default_taxon_post.png'

    include Spree::Core::S3Support
    supports_s3 :icon
        
    scope :published, lambda { where(:published_at => "published_at <= #{Time.now}", :active => true) }
    
    # Creates permalink based on Stringex's .to_url method
    def set_permalink
      if parent_id.nil?
        self.permalink = name.to_url if permalink.blank?
      else
        parent_taxon = TaxonPost.find(parent_id)
        self.permalink = [parent_taxon.permalink, (permalink.blank? ? name.to_url : permalink.split('/').last)].join('/')
      end
    end

    def active_posts
      scope = posts.published
      scope
    end

    def pretty_name
      ancestor_chain = self.ancestors.inject("") do |name, ancestor|
        name += "#{ancestor.name} -> "
      end
      ancestor_chain + "#{name}"
    end   
  end
end