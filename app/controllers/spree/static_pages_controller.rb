module Spree
  class StaticPagesController < BaseController
    before_filter :load_obj
    
    def contacts
      
    end
    
    def load_obj
      @static_pages = Spree::StaticPage.published
      if params[:path]
        @static_page = Spree::StaticPage.find(params[:path])
      end
    end
    
  end
end
