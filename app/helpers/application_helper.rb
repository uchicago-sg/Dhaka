module ApplicationHelper
  def root?
    request.env['PATH_INFO'] == '/' and not request.env['QUERY_STRING'].present? ? true : false
  end

  def resource?
    %w( listings users categories ).include? controller_name
  end

  def title(new_title=nil)
    if new_title
      content_for :title, new_title.html_safe
    else
      content_for?(:title) ? "#{content_for :title} - #{SITE_NAME}" : SITE_NAME
    end
  end

  def link_stylesheets *args
    content_for :head do
      stylesheet_link_tag *args
    end
  end

  def include_javascripts *args
    content_for :head do
      javascript_include_tag *args
    end
  end
end