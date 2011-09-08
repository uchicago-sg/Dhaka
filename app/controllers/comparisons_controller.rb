class ComparisonsController < ApplicationController
  # POST /compare
  def create
    session[:starred] ||= []
    session[:starred] << params['id'].to_i
    flash[:notice] = 'Successfully starred listing.'
    redirect_to :back
  end

  # GET /compare/:id
  def update
    if session[:starred].delete params['id'].to_i
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
      session[:starred].each do |listing_id|
        @listings << Listing.find(listing_id) rescue nil
      end
    end
    @listings.compact!
    @listings.keep_if { |l| can? :read, l }
    session[:starred] = @listings.map &:id
    @listings.reverse!
  end
end