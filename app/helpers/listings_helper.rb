module ListingsHelper
  def strip_tags_and_spaces(string)
    strip_tags string.gsub("&nbsp;", " ")
  end
  
  def show_more
    link_to "More", "", :class => "show-more", :id => "expand"
  end
end