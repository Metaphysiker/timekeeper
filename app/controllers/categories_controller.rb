class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  # GET /categories or /categories.json
  def index
    authorize Category
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
    authorize @category
  end

  # GET /categories/new
  def new
    @category = Category.new
    authorize @category
  end

  # GET /categories/1/edit
  def edit
    authorize @category
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    authorize @category

    respond_to do |format|
      if @category.save
        format.html { redirect_to manage_categories_account_path(@category.account), notice: "#{Category.model_name.human} #{Category.human_attribute_name("category_created_successfully")}" }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    authorize @category
    original_category_name = @category.name
    respond_to do |format|
      if @category.update(category_params)
        @category.account.work_times.where("(categories->'#{original_category_name}') is not null").each do |work_time|
          #byebug
          categories = work_time.categories
          categories.store(@category.name, categories[original_category_name])
          categories.delete(original_category_name)
          work_time.update(categories: categories)
        end
        format.html { redirect_to manage_categories_account_path(@category.account), notice: "#{Category.model_name.human} #{Category.human_attribute_name("category_updated_successfully")}" }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    authorize @category
    @category.destroy
    respond_to do |format|
      format.html { redirect_to manage_categories_account_path(@category.account), notice: "#{Category.model_name.human} #{Category.human_attribute_name("category_destroyed_successfully")}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :option_field, :account_id)
    end
end
