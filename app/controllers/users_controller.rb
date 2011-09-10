class UsersController < ApplicationController
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json

  # GET /users/:id
  def show
    if user_signed_in?
      if current_user.admin?
        @listings = Listing
      else
        @listings = Listing.unexpired.where :seller_id => @user.id
      end
    else
      @listings = @user.listings.searchable
    end
    @listings = @listings.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @user
  end
end