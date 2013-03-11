module Spree
  class Page < ActiveRecord::Base
    has_many :uploads, :as => :uploadable
    validate :no_attachment_errors
    
    attr_accessible :name, :permalink, :meta_description, :meta_keywords,
                    :content, :published_at, :attachment

    has_attached_file :attachment,
                      :styles => { :mini => '100x100>', :small => '200x200>', :medium => '3040x300>', :large => '600x600>' },
                      :default_style => :product,
                      :url => '/spree/pages/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/pages/:id/:style/:basename.:extension',
                      :convert_options => { :all => '-strip' }
    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    #after_post_process :find_dimensions

    # Load user defined paperclip settings
    if Spree::Config[:use_s3]
      s3_creds = { :access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket] }
      Spree::Page.attachment_definitions[:attachment][:storage] = :s3
      Spree::Page.attachment_definitions[:attachment][:s3_credentials] = s3_creds
      Spree::Page.attachment_definitions[:attachment][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::Page.attachment_definitions[:attachment][:bucket] = Spree::Config[:s3_bucket]
      Spree::Page.attachment_definitions[:attachment][:s3_protocol] = Spree::Config[:s3_protocol] unless Spree::Config[:s3_protocol].blank?
      Spree::Page.attachment_definitions[:attachment][:s3_host_alias] = Spree::Config[:s3_host_alias] unless Spree::Config[:s3_host_alias].blank?
    end

    #Spree::Page.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:attachment_styles])
    #Spree::Page.attachment_definitions[:attachment][:path] = Spree::Config[:attachment_path]
    #Spree::Page.attachment_definitions[:attachment][:url] = Spree::Config[:attachment_url]
    #Spree::Page.attachment_definitions[:attachment][:default_url] = Spree::Config[:attachment_default_url]
    #Spree::Page.attachment_definitions[:attachment][:default_style] = Spree::Config[:attachment_default_style]
    
    accepts_nested_attributes_for :uploads, :allow_destroy => true
    
    make_permalink :order => :name    
    def to_param
      permalink.present? ? permalink : (permalink_was || name.to_s.to_url)
    end
    
    def published?
      !self.published_at.blank?
    end
    
    def link_is_blank
      self.link.blank?
    end

    def content_is_blank
      self.content.blank?
    end

    #used by admin products autocomplete
    def mini_url
      attachment.url(:mini, false)
    end

    def find_dimensions
      temporary = attachment.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = attachment.path if filename.blank?
      geometry = Paperclip::Geometry.from_file(filename)
      self.attachment_width  = geometry.width
      self.attachment_height = geometry.height
    end

    # if there are errors from the plugin, then add a more meaningful message
    def no_attachment_errors
      unless attachment.errors.empty?
        # uncomment this to get rid of the less-than-useful interrim messages
        # errors.clear
        errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
        false
      end
    end
  end 
end
