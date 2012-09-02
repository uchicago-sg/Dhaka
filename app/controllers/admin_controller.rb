require 'yaml'

class AdminController < ApplicationController
  before_filter :check_authorized
  respond_to :html, :json

  # GET /admin
  def index
  end

  # GET /admin/duplicates
  def duplicates
    @listings = Listing.dupes.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @listings
  end

  # GET /admin/users
  def users
    @users = User.confirmed.order('created_at DESC').page(params[:page])
    respond_with @users
  end

  # GET /admin/confirmations
  def confirmations
    @users = User.unconfirmed.order('created_at DESC').page(params[:page])
    respond_with @users
  end

  # GET /admin/users/:user/update_roles
  def update_roles
    @user = User.find_by_permalink params[:user]
    @user.toggle_role params[:role]
    if @user.save
      respond_to do |format|
        format.html {
          flash[:notice] = 'Updated permissions successfully'
          redirect_to admin_users_path
        }
        format.json { render :json => { :status => :ok, :message => @user.roles } }
      end
    end
  end

  # GET /admin/users/:user/lock
  def lock
    @user = User.find_by_permalink params[:user]
    if @user.toggle_lock
      respond_to do |format|
        format.html {
          flash[:notice] = 'Toggled lock successfully'
          redirect_to admin_users_path
        }
        format.json { render :json => { :status => :ok, :message => @user.access_locked? } }
      end
    end
  end

  # GET /admin/users/:user/confirm
  def confirm
    @user = User.find_by_permalink params[:user]
    if @user.confirm!
      respond_to do |format|
        format.html {
          flash[:notice] = 'Confirmed successfully'
          redirect_to admin_users_path
        }
        format.json { render :json => { :status => :ok, :message => @user.access_locked? } }
      end
    end
  end


private
  def check_authorized
    unless user_signed_in? and current_user.admin?
      flash[:error] = 'You are not authorized to access this page.'
      redirect_to root_path
    end
  end
end