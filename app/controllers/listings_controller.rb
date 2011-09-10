class ListingsController < ApplicationController
  before_filter :process_order_param, :only   => %w( index search )
  before_filter :find_readable_listing, :only => %w( show )
  load_resource :find_by => :permalink, :except => %w( show search )
  authorize_resource
  respond_to :html, :json

  # GET /listings
  def index
    @listings = @search.result(:distinct => true).order(@order).page(params[:page])
    respond_with @listings
  end

  # GET /listings/new
  def new
    Listing::MAX_IMAGES.times { @listing.images.build }
    respond_with @listing
  end

  # POST /listings
  def create
    @listing.seller = current_user
    if @listing.save
      flash[:notice] = 'Listing successfully created'
      respond_with @listing, :status => :created, :location => @listing
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
    respond_with @listing
  end

  # GET /listings/:id/edit
  def edit
    if @listing.images.length < Listing::MAX_IMAGES
      (Listing::MAX_IMAGES - @listing.images.length).times { @listing.images.build }
    end
    respond_with @listing
  end

  # POST /listings/:id
  def update
    if @listing.update_attributes params[:listing]
      undo_link      = view_context.link_to "undo", revert_version_path(@listing.versions.last), :method => :post
      flash[:notice] = "Listing successfully edited, #{undo_link}".html_safe
      respond_with @listing, :status => :listing, :location => @listing
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

  # GET /listings/renew/:id
  def renew
    @listing.renew.save
    flash[:notice] = 'Listing successfully renewed'
    redirect_to :back
  end

  # GET /listings/publish/:id
  def publish
    @listing.publish.save
    flash[:notice] = 'Listing successfully published'
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to :root
    end
  end

  # POST /listings/publish/:id
  def unpublish
    @listing.unpublish.save
    flash[:notice] = 'Listing successfully unpublished'
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to :root
    end
  end

  # GET|POST /listings/search
  def search
    @include_expired = params[:include_expired].present? and ( params[:include_expired] == '1' or params[:include_expired] == 'on' )
    @images_present  = params[:images_present].present?  and ( params[:images_present]  == '1' or params[:images_present]  == 'on' )

    listings  = Listing.searchable
    listings  = listings.unexpired unless @include_expired
    listings  = listings.with_images if @images_present
    @search   = listings.search params[:q]
    @listings = @search.result(:distinct => true).order(@order).page(params[:page])
    respond_with @listings do |format|
      format.atom
      format.rss { redirect_to category_path(@category, :format => :atom), :status => :moved_permanently }
    end
  end


private
  def process_order_param
    i  = params[:order].to_i || 0
    i %= Listing::ORDER_BY.length
    @order = Listing::ORDER_BY[i][1]
  end

  # If a listing is published, great! Everyone can read it
  # If not, it's only accessible to those with publisher rights
  def find_readable_listing
    scope    = Listing.searchable
    scope    = Listing.unexpired if user_signed_in?
    @listing = scope.searchable.find_by_permalink params[:id]

    # Should probably be 404s, but whatever...
    raise CanCan::AccessDenied.new(nil, :show, Listing) unless @listing
    raise CanCan::AccessDenied.new(nil, :show, Listing) if @listing.unpublished? and cannot? :publish, @listing
  end
end