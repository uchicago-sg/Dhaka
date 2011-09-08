class ComparisonsController < ApplicationController
  # POST /compare
  def create
    session[:compare] ||= []
    session[:compare] << params['id'].to_i
    flash[:notice] = 'Successfully starred listing.'
    redirect_to :back
  end

  # GET /compare/:id
  def update
    if session[:compare].delete params['id'].to_i
      flash[:notice] = 'Successfully unstarred listing.'
    else
      flash[:notice] = 'No such listing to unstar.'
    end
    redirect_to :back
  end

  # GET /compare
  def show
    @listings = []
    if session[:compare]
      session[:compare].uniq!
      session[:compare].each do |listing_id|
        @listings << Listing.find(listing_id) rescue nil
      end
    end
    @listings.compact!
  end
end