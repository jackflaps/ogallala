module ApplicationHelper
  def include_controller_js
    scripts = ""

    scripts += javascript_include_tag "#{controller.controller_name}" if File.exist?("#{Rails.root}/app/assets/javascripts/#{controller_name}.js")

    scripts.html_safe
  end
end
