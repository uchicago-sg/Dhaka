class CategoriesController < ApplicationController
  load_resource :find_by => :permalink
  authorize_resource
  respond_to :html, :json

  # GET /categories
  def index
    @category = Category.all
    respond_with @categories.map(&:attributes)
  end

  # GET /categories/new
  def new
    @category = Category.new
    respond_with @category.attributes
  end

  # POST /categories
  def create
    @category = Category.new params[:category]
    if @category.save
      flash[:notice] = 'Category successfully created'
      respond_with(@category.attributes, :status => :created, :location => @category)
    else
      respond_with(@category.errors, :status => :unprocessable_entity) do |format|
        format.html do
          render :action => :new
        end
      end
    end
  end

  # GET /categories/:id
  def show
    @listings = @category.listings
    respond_with @category.attributes
  end

  # GET /categories/:id/edit
  def edit
    respond_with @category.attributes
  end

  # POST /categories/:id
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category successfully edited'
      respond_with(@category.attributes, :status => :categoryd, :location => @category)
    else
      respond_with(@category.errors, :status => :unprocessable_entity) do |format|
        format.html do
          render :action => :new
        end
      end
    end
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy
    flash[:notice] = 'Category successfully destroyed'
    respond_with @category
  end
end