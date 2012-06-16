module ApplicationHelper
  def root?
    request.env['PATH_INFO'] == '/' and not request.env['QUERY_STRING'].present? ? true : false
  end

  def resource?
    APP_RESOURCES.include? controller_name
  end

  def title new_title=nil
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

  def categories_search_path category=nil
    category_id = category.nil? ? 0 : category.id
    listings_path :q => { :categories_id_positive_and_eq => category_id }
  end

  def categories_search_link category=nil
    if category.nil?
      link_to 'All Categories', listings_path
    else
      link_to category.description, categories_search_path(category)
    end
  end
  
  def full_image_path asset, type
    return root_url[0..-2] + asset.photo.url(type)
  end
  
  # See http://stackoverflow.com/questions/223984/automatic-method-to-set-the-tabindex-using-form-helpers
  def autotab
    @current_tab ||= 0
    @current_tab += 1
  end

  def selected_if state
    return 'selected' if state
    return ''
  end
end