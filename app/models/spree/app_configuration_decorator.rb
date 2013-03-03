# This is the primary location for defining spree preferences
#
# The expectation is that this is created once and stored in
# the spree environment
#
# setters:
# a.color = :blue
# a[:color] = :blue
# a.set :color = :blue
# a.preferred_color = :blue
#
# getters:
# a.color
# a[:color]
# a.get :color
# a.preferred_color
#
Spree::AppConfiguration.class_eval do
  
  preference :store_default_email, :string, :default => 'spree@example.com'
  preference :store_default_contact_subject, :string, :default => "Contact form subject"
  preference :store_address, :string, :default => 'Address, 123 - 123456 City (IT)'
  preference :store_phone_number, :string, :default => '012 - 3456789'
  preference :store_fax_number, :string, :default => '012 - 3456789'
  preference :store_twitter_id, :string, :default => 'twitter_id'
  preference :store_facebook_id, :string, :default => 'facebook_id'
  preference :store_skype, :string, :default => 'spree_skype'
  preference :store_location, :string, :default => 'google_maps_location'
  preference :store_description, :text, :default => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, sem id vulputate auctor, dui lectus lacinia ipsum, placerat euismod felis tellus a nulla. Nunc fermentum tincidunt dui, ac iaculis quam elementum et. Mauris sit amet vehicula tortor. Maecenas euismod fringilla venenatis. In accumsan ultricies odio at venenatis. Duis aliquam euismod libero, nec eleifend massa fermentum iaculis. Donec imperdiet egestas ligula pretium aliquam.'
  preference :store_welcome_title, :string, :default => 'Welcome'
  preference :store_welcome_description, :text, :default => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, sem id vulputate auctor, dui lectus lacinia ipsum, placerat euismod felis tellus a nulla. Nunc fermentum tincidunt dui, ac iaculis quam elementum et. Mauris sit amet vehicula tortor. Maecenas euismod fringilla venenatis. In accumsan ultricies odio at venenatis. Duis aliquam euismod libero, nec eleifend massa fermentum iaculis. Donec imperdiet egestas ligula pretium aliquam.'
  preference :admin_post_per_page, :integer, :default => 10
  preference :post_per_page, :integer, :default => 5
  
end