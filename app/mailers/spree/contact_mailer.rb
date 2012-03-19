module Spree
  class ContactMailer < ActionMailer::Base
    helper 'spree/base'
    
    default :from => Spree::Config[:store_default_email]

    def contacts_form(name, email, text)
      @name = name
      @email = email
      @messaggio = text
      mail(:to => "#{email} - #{name}",
      :subject => "[Spree Ecommerce] - Contatto dal sito web")
    end
  end
end
