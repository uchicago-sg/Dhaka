module ListingsHelper
  def show_more
    link_to "More", "", :class => "show-more", :id => "expand"
  end
end