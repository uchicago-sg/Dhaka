class ApplicationController < ActionController::Base
  layout proc {|controller| controller.request.xhr? ? false : 'application' }
  before_filter :load_resources
  protect_from_forgery

  # Force CanCan to fail gracefully
  # Don't redirect, just show an error on the same page
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to(request.referer.nil? ? :root : request.referer)
  end

protected
  def load_resources
    @action     = "#{controller_name}##{action_name}"
    @categories = Category.all
    @search     = Listing.available.search params[:q]
  end
end