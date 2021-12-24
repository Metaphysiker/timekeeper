class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy area_chart_data donut_chart_data data_overview manage_categories]
  before_action :set_start_and_end_date, only: %i[show data_overview]


  def my_accounts
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  def manage_categories

  end

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1 or /accounts/1.json
  def show

  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def data_overview
    render layout: false
  end

  def area_chart_data
    render json: @account.area_chart_data(
      interval: params[:interval],
      start_date: params[:start_date],
      end_date: params[:end_date]
    ).to_json
  end

  def donut_chart_data
    render json: @account.donut_chart_data(
      start_date: params[:start_date],
      end_date: params[:end_date],
      category: params[:category]
    ).to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    def set_start_and_end_date
      if params[:start_date].present?
        @start_date = DateTime.parse(params[:start_date])
      elsif !@account.work_times.empty?
        @start_date = @account.work_times.order(:datetime).first.datetime
      else
        @start_date = DateTime.now
      end

      if params[:end_date].present?
        @end_date = DateTime.parse(params[:end_date])
      elsif !@account.work_times.empty?
        @end_date = @account.work_times.order(:datetime).last.datetime
      else
        @end_date = DateTime.now
      end
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :text, :user_id)
    end
end
