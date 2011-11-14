class ComparisonsController < ApplicationController
  respond_to :html, :only => :index
  before_filter :ensure_starred_session_variable_exists

  def index
    @listings = []
    @listings = Listing.available.order(Listing::DEFAULT_ORDER).find_all_by_permalink(session[:starred].uniq)
    session[:starred] = @listings.map &:permalink
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
    respond_with @listings
  end

  def star
    session[:starred] << params[:permalink]
    respond_to do |format|
      format.json { render :json => {:status => :ok, :message => session[:starred] } }
    end
  end

  def unstar
    session[:starred].delete params[:permalink]
    respond_to do |format|
      format.json { render :json => {:status => :ok, :message => params[:permalink] } }
    end
  end

protected
  def ensure_starred_session_variable_exists
    session[:starred] ||= []
  end
end