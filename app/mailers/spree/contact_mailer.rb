module Spree
  class ContactMailer < ActionMailer::Base
    helper 'spree/base'

    def contacts_form(name, email, text)
      @name = name
      @email = email
      @messaggio = text
      mail(:to => "#{name} <#{email}>", :subject => "#{Spree::Config[:site_name]} - Contatto dal sito web")
    end
  end
end
