require 'test_helper'

class VehiclePricesControllerTest < ActionController::TestCase
  setup do
    @vehicle_price = vehicle_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_price" do
    assert_difference('VehiclePrice.count') do
      post :create, vehicle_price: { adj_close: @vehicle_price.adj_close, close: @vehicle_price.close, high: @vehicle_price.high, low: @vehicle_price.low, open: @vehicle_price.open, trade_date: @vehicle_price.trade_date, vehicle_id: @vehicle_price.vehicle_id, volume: @vehicle_price.volume }
    end

    assert_redirected_to vehicle_price_path(assigns(:vehicle_price))
  end

  test "should show vehicle_price" do
    get :show, id: @vehicle_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle_price
    assert_response :success
  end

  test "should update vehicle_price" do
    patch :update, id: @vehicle_price, vehicle_price: { adj_close: @vehicle_price.adj_close, close: @vehicle_price.close, high: @vehicle_price.high, low: @vehicle_price.low, open: @vehicle_price.open, trade_date: @vehicle_price.trade_date, vehicle_id: @vehicle_price.vehicle_id, volume: @vehicle_price.volume }
    assert_redirected_to vehicle_price_path(assigns(:vehicle_price))
  end

  test "should destroy vehicle_price" do
    assert_difference('VehiclePrice.count', -1) do
      delete :destroy, id: @vehicle_price
    end

    assert_redirected_to vehicle_prices_path
  end
end
