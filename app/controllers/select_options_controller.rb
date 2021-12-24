class SelectOptionsController < ApplicationController
  before_action :set_select_option, only: %i[ show edit update destroy ]

  # GET /select_options or /select_options.json
  def index
    @select_options = SelectOption.all
  end

  # GET /select_options/1 or /select_options/1.json
  def show
  end

  # GET /select_options/new
  def new
    @select_option = SelectOption.new
  end

  # GET /select_options/1/edit
  def edit
  end

  # POST /select_options or /select_options.json
  def create
    @select_option = SelectOption.new(select_option_params)

    respond_to do |format|
      if @select_option.save
        format.html { redirect_to @select_option, notice: "Select option was successfully created." }
        format.json { render :show, status: :created, location: @select_option }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @select_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /select_options/1 or /select_options/1.json
  def update
    respond_to do |format|
      if @select_option.update(select_option_params)
        format.html { redirect_to @select_option, notice: "Select option was successfully updated." }
        format.json { render :show, status: :ok, location: @select_option }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @select_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /select_options/1 or /select_options/1.json
  def destroy
    @select_option.destroy
    respond_to do |format|
      format.html { redirect_to select_options_url, notice: "Select option was successfully destroyed." }
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
