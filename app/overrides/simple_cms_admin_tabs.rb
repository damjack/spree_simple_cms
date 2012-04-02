Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "pages_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(t('simple_cms.pages'), :url => spree.admin_static_pages_path) %>",
                     :disabled => false)                
=begin
Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "blogs_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:blogs, :url => spree.admin_blogs_path) %>",
                     :disabled => false)
                     
Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "uploads_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:uploads, :url => spree.admin_uploads_path) %>",
                     :disabled => false)
=end
