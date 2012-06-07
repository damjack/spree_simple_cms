module Spree
  class StaticPagesController < BaseController
    before_filter :load_obj
    
    def contacts
    end
    
    def show
      @page = Spree::StaticPage.find(params[:id])
    end
    
    def create_mail
      unless (params[:name].blank? && params[:email].blank? && params[:messaggio].blank?)
        Spree::ContactMailer.contacts_form(params[:name], params[:email], params[:messaggio]).deliver
        flash[:notice] = 'Email inviata correttamente'
      else
        flash[:notice] = 'Si e` verificato un problema durante l\'invio della mail. Verifica di aver compilato tutti i campi'
      end
      redirect_to contacts_url
    end
    
    def load_obj
      @static_pages = Spree::StaticPage.published
    end
    
  end
end
