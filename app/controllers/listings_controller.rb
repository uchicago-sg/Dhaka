class ListingsController < ApplicationController
  respond_to :html, :json
  # before_filter :authenticate_user!
  # load_and_authorize_resource

  # GET /listings
  def index
    @listings = Listing.all
    respond_with @listings.map(&:attributes)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    respond_with @listing.attributes
  end

  # POST /listings
  def create
    @listing = Listing.new(params[:listing])
    if @listing.save
      flash[:notice] = 'Listing successfully created'
      respond_with(@listing.attributes, :status => :created, :location => @listing)
    else
      respond_with(@listing.errors, :status => :unprocessable_entity) do |format|
        format.html do
          render :action => :new
        end
      end
    end
  end

  # GET /listings/:id
  def show
    @listing = Listing.find(params[:id])
    respond_with @listing.attributes
  end

  # GET /listings/:id/edit
  def edit
    @listing = Listing.find(params[:id])
    respond_with @listing.attributes
  end

  # POST /listings/:id
  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      flash[:notice] = 'Listing successfully edited'
      respond_with(@listing.attributes, :status => :listingd, :location => @listing)
    else
      respond_with(@listing.errors, :status => :unprocessable_entity) do |format|
        format.html do
          render :action => :new
        end
      end
    end
  end

  # DELETE /listings/:id
  def destroy
    Listing.delete(params[:id])
  end
end