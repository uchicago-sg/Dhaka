class ComparisonsController < ApplicationController

def create
  session[:compare] ||= [] 
  session[:compare] << params[:id].to_i
  render :nothing => true
end

def index
  @listings = []
  if session[:compare]
    session[:compare].each do |id|
      @listings << Listing.find(id) unless id.blank?
    end
  end
end

end
