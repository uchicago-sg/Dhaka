class ListingsController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource

  # GET /listings
  def index
    if params[:search].present?
    else
      @listings = Listing.all
      respond_with @listings.map(&:attributes)
    end
  end

  # GET /listings/new
  def new
    respond_with @listing.attributes
  end

  # POST /listings
  def create
    @listing.seller = current_user
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
    respond_with @listing.attributes
  end

  # GET /listings/:id/edit
  def edit
    respond_with @listing.attributes
  end

  # POST /listings/:id
  def update
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
    @listing.destroy
    flash[:notice] = 'Listing successfully destroyed'
    respond_with @listing
  end
end