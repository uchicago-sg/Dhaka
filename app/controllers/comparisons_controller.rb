class ComparisonsController < ApplicationController
  # GET /starred
  def index
    @listings = []
    @listings = Listing.available.order(Listing::DEFAULT_ORDER).find_all_by_permalink(session[:starred].uniq) if session[:starred]
    session[:starred] = @listings.map &:permalink
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
  end

  # POST /starred
  def star
    session[:starred] ||= []
    session[:starred] << params[:permalink]
    flash[:notice] = 'Successfully starred listing'
    redirect_to :back
  end

  # GET /starred/:permalink
  def unstar
    if session[:starred].delete params[:permalink]
      flash[:notice] = 'Successfully unstarred listing'
    else
      flash[:notice] = 'No such listing to unstar'
    end
    redirect_to :back
  end
end