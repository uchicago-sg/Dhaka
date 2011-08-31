class ApplicationController < ActionController::Base
  before_filter :load_sidebar_resources
  after_filter  :initialize_cookie
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
  # This is pretty hacky but it works
  def initialize_cookie
    unless cookies[:visit].to_i > 2 # Don't want to creepily keep counting
      cookies[:visit] = cookies[:visit].to_i + 1 
    end
  end
end