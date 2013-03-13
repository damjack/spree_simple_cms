Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "cms_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= dropdow_tab(:cms, :childs => ['static_pages', 'posts', 'uploads'], :icons => ['icon-book', 'icon-comments', 'icon-upload'], :class => 'dropdown-menu') %>")

