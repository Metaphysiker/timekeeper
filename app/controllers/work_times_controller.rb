class WorkTimesController < ApplicationController
  before_action :set_work_time, only: %i[ show edit update destroy ]
  after_action :verify_authorized
  #after_action :verify_authorized

  # GET /work_times or /work_times.json
  def index
    authorize WorkTime
    @work_times = WorkTime.all
  end

  # GET /work_times/1 or /work_times/1.json
  def show
    authorize @work_time
  end

  # GET /work_times/new
  def new
    @work_time = WorkTime.new
    authorize @work_time
  end

  # GET /work_times/1/edit
  def edit
    authorize @work_time
  end

  # POST /work_times or /work_times.json
  def create
    @work_time = WorkTime.new(work_time_params)
    authorize @work_time

    respond_to do |format|
      if @work_time.save
        format.html { redirect_to account_path(@work_time.account), notice: "#{WorkTime.model_name.human} #{WorkTime.human_attribute_name("work_time_created_successfully")}" }
        format.json { render :show, status: :created, location: @work_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @work_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_times/1 or /work_times/1.json
  def update
    authorize @work_time
    respond_to do |format|
      if @work_time.update(work_time_params)
        format.html { redirect_to account_path(@work_time.account), notice: "#{WorkTime.model_name.human} #{WorkTime.human_attribute_name("work_time_updated_successfully")}" }
        format.json { render :show, status: :ok, location: @work_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @work_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_times/1 or /work_times/1.json
  def destroy
    authorize @work_time
    @work_time.destroy
    account = @work_time.account
    respond_to do |format|
      format.html { redirect_to account_path(account), notice: "#{WorkTime.model_name.human} #{WorkTime.human_attribute_name("work_time_destroyed_successfully")}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_time
      @work_time = WorkTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_time_params
      params.require(:work_time).permit(:task, :minutes, :datetime, :account_id, :categories => {})
    end
end
