class ComparisonsController < ApplicationController

def create
  # Could use +=, but the handy properties of nil.to_s get around the initial setting issue, whereas += does not.
  # They should change += to += unless nil else =
  session[:compare] = session[:compare].to_s + "&#{params[:id]}"
  render :nothing => true
end

def index
  @listings = []
  if session[:compare]
    session[:compare].split("&").each do |id|
      @listings << Listing.find(id) unless id.blank?
    end
  end
end

end
