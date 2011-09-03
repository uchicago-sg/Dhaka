class ComparisonsController < ApplicationController
  # POST /compare
  def create
    session[:compare] ||= []
    session[:compare] << params[:id].to_i
    render :nothing => true
  end

  # GET /compare
  def show
    @listings = []
    if session[:compare]
      session[:compare].each do |listing_id|
        @listings << Listing.find(listing_id) unless id.blank?
      end
    end
  end
end