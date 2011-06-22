class ApplicationController < ActionController::Base
  protect_from_forgery

  # Force CanCan to fail gracefully
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

private
  before_filter :instantiate_special_instance_variables

  # Give our views access to some special information
  def instantiate_special_instance_variables
    @current_action     = action_name
    @current_controller = controller_name
  end
end