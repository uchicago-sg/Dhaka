class ApplicationController < ActionController::Base
  before_filter :load_resources, :process_mode_param, :process_order_param
  protect_from_forgery

  # http://stackoverflow.com/a/19285791
  before_action :configure_permitted_parameters, :if => :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u|
      u.permit(:name, :email)
    }
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:name, :email, :password, :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    }
  end

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
    # i  = params[:mode].to_i || 0
    # i %= Listing::MODES.length
    # @compact_mode = action_name != 'search' && Listing::MODES[i] == 'Compact'
    @compact_mode = true
  end

  def process_order_param
    i  = params[:order].to_i || 0
    i %= Listing::ORDER_BY.length
    @order = Listing::ORDER_BY[i][1]
  end
end
