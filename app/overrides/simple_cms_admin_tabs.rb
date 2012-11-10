Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "pages_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(t('simple_cms.pages'), :url => spree.admin_static_pages_path) %>",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "posts_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:posts, :url => spree.admin_posts_path) %>",
                     :disabled => false)

