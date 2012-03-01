class UsersController < ApplicationController
  # custom_actions :resource => :change_password
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json

  # GET /users/:id
  def show
    if user_signed_in? and @user.id == current_user.id
      @listings = @user.listings
    else
      @listings = @user.listings.available
    end

    @listings = @listings.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @user
  end

  # GET /users/:id/edit
  def edit
    respond_with @user
  end

  # POST /users/:id
  def update
    if params[:user][:password]
      if @user.update_with_password(params[:user])
        sign_in(@user, bypass: true)
        flash[:notice] = 'Password successfully updated'
        respond_with @user, :status => :ok, :location => user_path(@user)
      else
        render :change_password
      end
    elsif @user.update_attributes params[:user]
      flash[:notice] = 'User successfully edited'
      respond_with @user, :status => :ok, :location => user_path(@user)
    else
      respond_with @category.errors, :status => :unprocessable_entity do |format|
        format.html do
          render :action => :new
        end
      end
    end
  end
end