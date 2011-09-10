class UsersController < ApplicationController
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json

  # GET /users/:id
  def show
    if user_signed_in? and @user.id == current_user.id
      @listings = Listing.unscoped.where :seller_id => @user.id
    else
      @listings = @user.listings
    end
    @listings = @listings.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @user
  end
end