module Spree
  class StaticPagesController < BaseController
    before_filter :load_obj
    
    def contacts
      
    end
    
    def create_mail
      MailNotification.generic_form(params[:name], params[:email], params[:messaggio]).deliver
      flash[:notice] = 'Email inviata correttamente'
      redirect_to contacts_url
    end
    
    def load_obj
      @static_pages = Spree::StaticPage.published
      if params[:path]
        @static_page = Spree::StaticPage.find(params[:path])
      end
    end
    
  end
end
