class ApplicationController < ActionController::Base
  before_filter :load_sidebar_resources
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
end