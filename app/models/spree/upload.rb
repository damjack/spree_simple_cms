module Spree
  class Upload < ActiveRecord::Base
    belongs_to :uploadable, :polymorphic => true

    validate :no_image_errors
    has_attached_file :attachment,
                      :styles => { :thumbnail => "100x100#", :small=> "200x200#", :medium => "350x350#", :large => "450x450#" }

    scope :by_position, lambda { where(:position => "position ASC") }

    #TODO: spostare in libreria
    def no_image_errors
      unless attachment.errors.empty?
        errors.add :image, "Paperclip returned errors for file '#{image_file_name}' - check ImageMagick installation or image source file."
        false
      end
    end

  end
end
