module Spree
  class StaticPagesController < Spree::StoreController
    before_filter :load_page, :only => :show
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/taxons'

    respond_to :html
    
    def contacts
    end
    
    def show
      return unless @static_page
    end
    
    def create_mail
      unless (params[:name].blank? && params[:email].blank? && params[:messaggio].blank?)
        Spree::ContactMailer.contact_form(params[:name], params[:email], params[:messaggio]).deliver
        flash[:notice] = t('create_mail_static_page')
      else
        flash[:notice] = t('not_create_mail_static_page')#'Si e` verificato un problema durante l\'invio della mail. Verifica di aver compilato tutti i campi'
      end
      redirect_to contacts_url
    end
    
    private
    def accurate_title
      @static_page ? @static_page.title : super
    end
    
    def load_page
      @static_page = Spree::StaticPage.find_by_permalink!(params[:id])
    end
  end
end
