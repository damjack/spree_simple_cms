Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "add_configuration_line",
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :text => "<%= configurations_menu_item(t('store_settings'), admin_store_settings_url, t('manage_store_settings')) %>",
                     :disabled => false)