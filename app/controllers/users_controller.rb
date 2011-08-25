class UsersController < ApplicationController
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json

  # GET /users/:id
  def show
    @listings = @user.listings.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @user
  end
end