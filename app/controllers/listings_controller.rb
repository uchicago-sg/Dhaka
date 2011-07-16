class ListingsController < ApplicationController
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json


  # GET /listings
  def index
    if params[:search].present?
      @listings = [] # TODO
    else
      @listings = Listing.order(:description).page(params[:page]).per(50)
    end
    respond_with @listings.map(&:attributes)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    respond_with @listing.attributes
  end

  # POST /listings
  def create
    @listing = Listing.new params[:listing]
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
  
  require File.dirname(__FILE__) + '/listings_controller'
  

  # GET /listings/:id/edit
  def edit
    respond_with @listing.attributes
  end
  
  # POST /listings/:id
  def update
    if @listing.update_attributes(params[:listing])
      undo_link = view_context.link_to("undo", revert_version_path(@listing.versions.last), :method => :post)
      flash[:notice] = "Listing successfully edited, <b>#{undo_link}</b>".html_safe
      respond_with(@listing.attributes, :status => :listing, :location => @listing)
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
    undo_link = view_context.link_to("undo", revert_version_path(@listing.versions.last), :method => :post)
    flash[:notice] = "Listing successfully destroyed, <b>#{undo_link}</b>".html_safe
    respond_with @listing
  end
end