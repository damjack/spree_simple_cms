module Spree
  module Admin
    class StoreSettingsController < BaseController
      def show
        @preferences = ['store_name', 'store_default_email', 'store_address',
                        'store_phone_number', 'store_fax_number', 'store_twitter_uri',
                        'store_facebook_uri', 'store_pinterest_uri', 'store_youtube_uri',
                        'store_google_plus_uri', 'store_linkedin_uri', 'store_skype', 'store_location',
                        'store_description', 'store_welcome_title', 'store_welcome_description']
      end

      def edit
        @preferences = [:store_name, :store_default_email, :store_address,
                        :store_phone_number, :store_fax_number, :store_twitter_uri,
                        :store_facebook_uri, :store_pinterest_uri, :store_youtube_uri,
                        :store_google_plus_uri, :store_linkedin_uri, :store_skype, :store_location,
                        :store_description, :store_welcome_title, :store_welcome_description]
      end

      def update
        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        redirect_to admin_store_settings_path
      end
      
    end
  end
end