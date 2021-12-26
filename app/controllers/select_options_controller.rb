class SelectOptionsController < ApplicationController
  before_action :set_select_option, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  # GET /select_options or /select_options.json
  def index
    authorize SelectOption
    @select_options = SelectOption.all
  end

  # GET /select_options/1 or /select_options/1.json
  def show
    authorize @select_option
  end

  # GET /select_options/new
  def new
    @select_option = SelectOption.new
    authorize @select_option
  end

  # GET /select_options/1/edit
  def edit
    authorize @select_option
  end

  # POST /select_options or /select_options.json
  def create
    @select_option = SelectOption.new(select_option_params)
    authorize @select_option

    respond_to do |format|
      if @select_option.save
        format.html { redirect_to manage_categories_account_path(@select_option.category.account), notice: "#{SelectOption.model_name.human} #{SelectOption.human_attribute_name("created_successfully")}" }
        format.json { render :show, status: :created, location: @select_option }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @select_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /select_options/1 or /select_options/1.json
  def update
    authorize @select_option
    respond_to do |format|
      if @select_option.update(select_option_params)
        format.html { redirect_to manage_categories_account_path(@select_option.category.account), notice: "#{SelectOption.model_name.human} #{SelectOption.human_attribute_name("updated_successfully")}" }
        format.json { render :show, status: :ok, location: @select_option }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @select_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /select_options/1 or /select_options/1.json
  def destroy
    authorize @select_option
    @select_option.destroy
    respond_to do |format|
      format.html { redirect_to manage_categories_account_path(@select_option.category.account), notice: "#{SelectOption.model_name.human} #{SelectOption.human_attribute_name("destroyed_successfully")}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_select_option
      @select_option = SelectOption.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def select_option_params
      params.require(:select_option).permit(:name, :category_id)
    end
end
