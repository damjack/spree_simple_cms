module Spree
  class ContactMailer < ActionMailer::Base
    helper 'spree/base'

    def contacts_form(name, email, text)
      @name = name
      @email = email
      @messaggio = text
      mail(:from => "#{email} <#{name}>",
      :to => "#{Spree::Config[:store_default_email]}"
      :subject => "#{Spree::Config[:site_name]} - Contatto dal sito web")
    end
  end
end
