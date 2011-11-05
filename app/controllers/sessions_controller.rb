class SessionsController < Devise::SessionsController
  before_filter :ensure_params_exist, :except => :new

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_to do |format|
      format.html do
        respond_with resource, :location => redirect_location(resource_name, resource)
      end

      format.json do
        render :json => { :success => true, :authentication_token => current_user.authentication_token }, :status => :ok
      end
    end
  end

private
  def ensure_params_exist
    return unless params[:user][:email].blank? rescue nil
    render :json => { :error => 'Invalid email or password.' }, :status => 422
  end
end