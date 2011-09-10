class ComparisonsController < ApplicationController
  # POST /compare/:permalink
  def create
    session[:starred] ||= []
    session[:starred] << params[:permalink]
    flash[:notice] = 'Successfully starred listing'
    redirect_to :back
  end

  # PUT /compare/:permalink
  def update
    if session[:starred].delete params[:permalink]
      flash[:notice] = 'Successfully unstarred listing'
    else
      flash[:notice] = 'No such listing to unstar'
    end
    redirect_to :back
  end

  # GET /compare
  def show
    @listings = []
    @listings = Listing.order(Listing::DEFAULT_ORDER).find_all_by_permalink(session[:starred].uniq) if session[:starred]
    session[:starred] = @listings.map &:permalink
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
  end
end