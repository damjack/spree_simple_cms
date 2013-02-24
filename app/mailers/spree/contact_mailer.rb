module Spree
  class ContactMailer < ActionMailer::Base
    helper 'spree/base'

    def contacts_form(name, email, text)
      @name = name
      @email = email
      @messaggio = text
      mail(:to => "#{Spree::Config[:store_default_email]}", :from => "#{email} <#{name}>", :subject => "#{Spree::Config[:site_name]} - Contatto dal sito web")
    end
  end
end
