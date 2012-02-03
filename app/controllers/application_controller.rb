class ApplicationController < ActionController::Base
  layout proc {|controller| controller.request.xhr? ? false : 'application' }
  before_filter :load_resources, :process_mode_param, :process_order_param
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

  def process_mode_param
    i  = params[:mode].to_i || 0
    i %= Listing::MODES.length
    @compact_mode = action_name != 'search' && Listing::MODES[i] == 'Compact'
  end

  def process_order_param
    i  = params[:order].to_i || 0
    i %= Listing::ORDER_BY.length
    @order = Listing::ORDER_BY[i][1]
  end
end