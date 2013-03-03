module Spree
  class ContactMailer < ActionMailer::Base
    helper 'spree/base'

    def contact_form(name, email, text)
      @name = name
      @email = email
      @messaggio = text
      mail(:to => Spree::Config[:store_default_email], :subject => "#{Spree::Config[:site_name]} - #{Spree::Config[:store_default_contact_subject]}")
    end
  end
end
