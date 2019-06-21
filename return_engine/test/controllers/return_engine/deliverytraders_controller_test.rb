require 'test_helper'

module ReturnEngine
  class DeliverytradersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @deliverytrader = return_engine_deliverytraders(:one)
    end

    test "should get index" do
      get deliverytraders_url
      assert_response :success
    end

    test "should get new" do
      get new_deliverytrader_url
      assert_response :success
    end

    test "should create deliverytrader" do
      assert_difference('Deliverytrader.count') do
        post deliverytraders_url, params: { deliverytrader: { name: @deliverytrader.name } }
      end

      assert_redirected_to deliverytrader_url(Deliverytrader.last)
    end

    test "should show deliverytrader" do
      get deliverytrader_url(@deliverytrader)
      assert_response :success
    end

    test "should get edit" do
      get edit_deliverytrader_url(@deliverytrader)
      assert_response :success
    end

    test "should update deliverytrader" do
      patch deliverytrader_url(@deliverytrader), params: { deliverytrader: { name: @deliverytrader.name } }
      assert_redirected_to deliverytrader_url(@deliverytrader)
    end

    test "should destroy deliverytrader" do
      assert_difference('Deliverytrader.count', -1) do
        delete deliverytrader_url(@deliverytrader)
      end

      assert_redirected_to deliverytraders_url
    end
  end
end
