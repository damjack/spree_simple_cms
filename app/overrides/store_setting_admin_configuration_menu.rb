Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_store_setting_link_configuration_menu",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => %q{<%= configurations_sidebar_menu_item t("simple_cms.store_settings"), admin_store_settings_url %>})

Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "add_store_setting_to_configuration_menu",
                     :insert_after => "[data-hook='admin_configurations_menu']",
                     :partial => "spree/admin/shared/store_setting_configurations_menu")