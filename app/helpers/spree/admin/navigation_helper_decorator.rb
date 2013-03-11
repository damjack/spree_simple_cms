Spree::Admin::NavigationHelper.module_eval do
  # Make an admin tab that coveres one or more resources supplied by symbols
  # Option hash may follow. Valid options are
  #   * :label to override link text, otherwise based on the first resource name (translated)
  #   * :route to override automatically determining the default route
  #   * :match_path as an alternative way to control when the tab is active, /products would match /admin/products, /admin/products/5/variants etc.
  def dropdow_tab(*args)
    options = {:label => args.first.to_s}
    if args.last.is_a?(Hash)
      options = options.merge(args.pop)
    end
    
    child = options[:childs].map do |c|
      destination_url = spree.send("admin_#{c}_path")
      titleized_label = t(c.to_sym, :default => c).titleize
      css_classes = []
      if options[:icons]
        link = link_to_with_icon(options[:icons][options[:childs].index(c)], titleized_label, destination_url)
        css_classes << 'tab-with-icon'
      else
        link = link_to(titleized_label, destination_url)
      end
      
      if options[:css_class]
        css_classes << options[:css_class]
      end
      content_tag(:p, link, :class => css_classes.join(' '))
    end.join()
    
    selected = options[:childs].include?(controller.controller_name)
    
    link_down = link_to("<i class='icon-chevron-down'></i> #{t(options[:label].to_sym, :default => options[:label]).titleize}".html_safe, "javascript: void(0)", :class => "dropdown-toggle")
    down = content_tag(:div, child.html_safe, :class => "dropdown")
    content_tag('li', link_down + down, :class => "#{options[:class]} tab-with-icon #{'selected' if selected}")
  end
end