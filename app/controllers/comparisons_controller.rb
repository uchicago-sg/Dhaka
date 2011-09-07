class ComparisonsController < ApplicationController
  # POST /compare
  def create
    session[:compare] ||= []
    session[:compare] << params['id'].to_i
    redirect_to compare_url
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