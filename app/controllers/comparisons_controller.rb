class ComparisonsController < ApplicationController
  # POST /compare
  def create
    session[:starred] ||= []
    session[:starred] << params[:permalink]
    flash[:notice] = 'Successfully starred listing.'
    redirect_to :back
  end

  # GET /compare/:permalink
  def update
    if session[:starred].delete params[:permalink]
      flash[:notice] = 'Successfully unstarred listing.'
    else
      flash[:notice] = 'No such listing to unstar.'
    end
    redirect_to :back
  end

  # GET /compare
  def show
    @listings = []
    if session[:starred]
      session[:starred].uniq!
      session[:starred].each do |listing_permalink|
        @listings << Listing.find_by_permalink(listing_permalink) rescue nil
      end
    end
    @listings.compact!
    session[:starred] = @listings.map &:permalink
    @listings.reverse!
  end
end