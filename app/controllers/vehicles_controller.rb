class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

  def chart
    
    if params[:search]
      @vehicles = Vehicle.search(params[:search]).order("sharpe_ratio DESC").paginate(:page => params[:page])
    else
      @vehicles = Vehicle.all.order("sharpe_ratio DESC").paginate(:page => params[:page])
    end
      #@vehicle = Vehicle.where(" return is not null").order("sharpe_ratio DESC").paginate(:page => params[:page])
  end
  
  def search
    if params[:vehicle]
      @vehicle = Vehicle.find_by_ticker(params[:vehicle])
      @vehicle ||= Vehicle.new_from_lookup(params[:vehicle])
    end

    if @vehicle
      # render json: @vehicle
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  # GET /vehicles
  # GET /vehicles.json
  def index
    if params[:vehicle]
      @vehicles = Vehicle.find_by_ticker(params[:vehicle])
    else
      @vehicles = Vehicle.all
    end
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)
    new_stock = StockQuote::Stock.quote(@vehicle.ticker)
    @vehicle.name = new_stock.name
    @vehicle.last_price= new_stock.last_trade_price_only

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_params
      # params.require(:vehicle).permit(:ticker, :name, :currency, :last_price)
      params.require(:vehicle).permit(:ticker)
    end
    
    def require_same_user
      if current_user != @portfolio.user 
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path
      end
    end
end
