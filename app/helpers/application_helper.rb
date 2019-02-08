module ApplicationHelper
  # set our form builder as the default to get the nested form methods
  ActionView::Base.default_form_builder = OgallalaFormBuilder

  def include_controller_js
    scripts = ""

    scripts += javascript_include_tag "#{controller.controller_name}" if File.exist?("#{Rails.root}/app/assets/javascripts/#{controller_name}.js")

    scripts.html_safe
  end
end
