class VehiclePricesController < ApplicationController
  before_action :set_vehicle_price, only: [:show, :edit, :update, :destroy]

  # GET /vehicle_prices
  # GET /vehicle_prices.json
  def index
    @vehicle_prices = VehiclePrice.all
  end

  # GET /vehicle_prices/1
  # GET /vehicle_prices/1.json
  def show
  end

  # GET /vehicle_prices/new
  def new
    @vehicle_price = VehiclePrice.new
  end

  # GET /vehicle_prices/1/edit
  def edit
  end

  # POST /vehicle_prices
  # POST /vehicle_prices.json
  def create
    @vehicle_price = VehiclePrice.new(vehicle_price_params)

    respond_to do |format|
      if @vehicle_price.save
        format.html { redirect_to @vehicle_price, notice: 'Vehicle price was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle_price }
      else
        format.html { render :new }
        format.json { render json: @vehicle_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_prices/1
  # PATCH/PUT /vehicle_prices/1.json
  def update
    respond_to do |format|
      if @vehicle_price.update(vehicle_price_params)
        format.html { redirect_to @vehicle_price, notice: 'Vehicle price was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle_price }
      else
        format.html { render :edit }
        format.json { render json: @vehicle_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_prices/1
  # DELETE /vehicle_prices/1.json
  def destroy
    @vehicle_price.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_prices_url, notice: 'Vehicle price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_price
      @vehicle_price = VehiclePrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_price_params
      params.require(:vehicle_price).permit(:vehicle_id, :trade_date, :open, :volume, :high, :low, :close, :adj_close)
    end
end
