module Spree
  module PagesHelper
    
    def pages_list_link(params)
      page = Spree::StaticPage.published.order("position ASC")
      items = page.map do |pg|
        content_tag(:li, link_to(pg.name, page_path("#{pg.slug}")))
      end
      
      content_tag(:ul, raw(items.join("\n")), :class => params[:class])
    end
    
  end
end
