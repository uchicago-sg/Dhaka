module ApplicationHelper
  def title
    @title.nil? ? SITE_NAME : "#{@title} - #{SITE_NAME}"
  end

  def root?
    request.env['PATH_INFO'] == '/' ? true : false
  end

  def stylesheet( *args )
    content_for( :head ) do
      stylesheet_link_tag( *args )
    end
  end

  def javascript( *args )
    content_for( :head ) do
      javascript_include_tag( *args )
    end
  end
end
