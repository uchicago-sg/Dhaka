class UsersController < ApplicationController
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json

  # GET /users/:id
  def show
    @listings = @user.listings.searchable.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @user
  end

  # GET /dashboard
  def dashboard
    @user     = current_user
    @listings = @user.listings.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @user
  end
end