class ApplicationController < ActionController::Base
  before_filter :load_sidebar_resources
  after_filter  :set_visited_cookie
  protect_from_forgery
  layout proc {|controller| controller.request.xhr? ? false : "application" }

  # Force CanCan to fail gracefully
  # Don't redirect, just show an error on the same page
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to(request.referer.nil? ? :root : request.referer)
  end

protected
  def load_sidebar_resources
    @categories = Category.all
  end

  def set_visited_cookie
    cookies.permanent[:visited] = true unless cookies[:visited]
  end
end