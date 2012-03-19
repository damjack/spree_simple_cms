module Spree
  class MailNotification < ActionMailer::Base
    default :from => "spree@diginess.it"

    def generic_form(name, email, text)
      @name = name
      @email = email
      @messaggio = text
      mail(:to => MAIL_RECIPIENT,
      :subject => "[Spree Ecommerce] - Contatto dal sito web")
    end
  end
end
