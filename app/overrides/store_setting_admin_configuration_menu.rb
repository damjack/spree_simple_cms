Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_store_settings",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<%= configurations_sidebar_menu_item t(:store_settings), edit_admin_store_settings_url %>")
