# class CategoriesController < ApplicationController
#   before_action :set_category, only: [:show, :edit, :update, :destroy]
#
#   # GET /categories
#   # GET /categories.json
#   def index
#     @categories = Category.all
#   end
#
#   # GET /categories/1
#   # GET /categories/1.json
#   def show
#   end
#
#   # GET /categories/new
#   def new
#     @category = Category.new
#   end
#
#   # GET /categories/1/edit
#   def edit
#   end
#
#   # POST /categories
#   # POST /categories.json
#   def create
#     @category = Category.new(category_params)
#
#     respond_to do |format|
#       if @category.save
#         format.html { redirect_to @category, notice: 'Category was successfully created.' }
#         format.json { render :show, status: :created, location: @category }
#       else
#         format.html { render :new }
#         format.json { render json: @category.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /categories/1
#   # PATCH/PUT /categories/1.json
#   def update
#     respond_to do |format|
#       if @category.update(category_params)
#         format.html { redirect_to @category, notice: 'Category was successfully updated.' }
#         format.json { render :show, status: :ok, location: @category }
#       else
#         format.html { render :edit }
#         format.json { render json: @category.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /categories/1
#   # DELETE /categories/1.json
#   def destroy
#     @category.destroy
#     respond_to do |format|
#       format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_category
#     @category = Category.find(params[:id])
#   end
#
#   # Never trust parameters from the scary internet, only allow the white list through.
#   def category_params
#     params.require(:category).permit(:name)
#   end
# end


class CategoriesController < ApplicationController
  load_resource :find_by => :permalink
  # authorize_resource
  respond_to :html, :json

  # GET /categories
  def index
    @category = Category.all
    @listings = Listing.available.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @categories do |format|
      format.atom
      format.rss { redirect_to category_path(@category, :format => :atom), :status => :moved_permanently }
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
    respond_with @category
  end

  # POST /categories
  def create
    @category = Category.new params[:category]
    if @category.save
      flash[:notice] = 'Category successfully created'
      respond_with @category, :status => :created, :location => @category
    else
      respond_with @category.errors, :status => :unprocessable_entity do |format|
        format.html do
          render :action => :new
        end
      end
    end
  end

  # GET /categories/:id
  def show
    @listings = @category.listings.available.order(Listing::DEFAULT_ORDER).page(params[:page])
    respond_with @category do |format|
      format.atom
      format.rss { redirect_to category_path(@category, :format => :atom), :status => :moved_permanently }
    end
  end

  # GET /categories/:id/edit
  def edit
    respond_with @category
  end

  # POST /categories/:id
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category successfully edited'
      respond_with @category, :status => :ok, :location => @category
    else
      respond_with @category.errors, :status => :unprocessable_entity do |format|
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
