module ApplicationHelper
  def root?
    request.env['PATH_INFO'] == '/' ? true : false
  end

  def title(new_title=nil)
    content_for :title do
      new_title.nil? ? SITE_NAME : "#{new_title} - #{SITE_NAME}"
    end
  end

  def stylesheet(*args)
    content_for(:head) do
      stylesheet_link_tag(*args)
    end
  end

  def javascript(*args)
    content_for(:head) do
      javascript_include_tag(*args)
    end
  end
end
