class ListingsController < ApplicationController
  load_resource :find_by => :permalink, :except => %w( index )
  authorize_resource
  respond_to :html, :json

  # GET /listings
  def index
    params[:q].delete :categories_id_eq if params[:q] and params[:q][:categories_id_eq] == '0' # Remove constraints when attempting to collect all categories
    @search   = Listing.search params[:q]
    @listings = @search.result(:distinct => true).order('created_at DESC').page(params[:page])
    respond_with @listings.map &:attributes
  end

  # GET /listings/new
  def new
    3.times { @listing.images.build }
    respond_with @listing.attributes
  end

  # POST /listings
  def create
    @listing.seller = current_user
    if @listing.save
      flash[:notice] = 'Listing successfully created'
      respond_with @listing.attributes, :status => :created, :location => @listing
    else
      respond_with @listing.errors, :status => :unprocessable_entity do |format|
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
    if @listing.update_attributes params[:listing]
      undo_link      = view_context.link_to "undo", revert_version_path(@listing.versions.last), :method => :post
      flash[:notice] = "Listing successfully edited, #{undo_link}".html_safe
      respond_with @listing.attributes, :status => :listing, :location => @listing
    else
      respond_with @listing.errors, :status => :unprocessable_entity do |format|
        format.html { render :action => :new }
      end
    end
  end

  # DELETE /listings/:id
  def destroy
    @listing.destroy
    undo_link      = view_context.link_to "undo", revert_version_path(@listing.versions.last), :method => :post
    flash[:notice] = "Listing successfully destroyed, #{undo_link}".html_safe
    respond_with @listing
  end

  # GET|POST /listings/search
  def search
    params[:q].delete :categories_id_eq if params[:q] and params[:q][:categories_id_eq] == '0' # Remove constraints when attempting to collect all categories
    @search   = Listing.search params[:q]
    @listings = @search.result(:distinct => true).order('created_at DESC').page(params[:page])
    respond_with @listings.map &:attributes
  end
end