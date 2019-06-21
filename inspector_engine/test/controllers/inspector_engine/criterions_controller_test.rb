require 'test_helper'

module InspectorEngine
  class CriterionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @criterion = inspector_engine_criterions(:one)
    end

    test "should get index" do
      get criterions_url
      assert_response :success
    end

    test "should get new" do
      get new_criterion_url
      assert_response :success
    end

    test "should create criterion" do
      assert_difference('Criterion.count') do
        post criterions_url, params: { criterion: { houhou: @criterion.houhou, houhou_eng: @criterion.houhou_eng, item_type: @criterion.item_type, kijun: @criterion.kijun, kijun_eng: @criterion.kijun_eng } }
      end

      assert_redirected_to criterion_url(Criterion.last)
    end

    test "should show criterion" do
      get criterion_url(@criterion)
      assert_response :success
    end

    test "should get edit" do
      get edit_criterion_url(@criterion)
      assert_response :success
    end

    test "should update criterion" do
      patch criterion_url(@criterion), params: { criterion: { houhou: @criterion.houhou, houhou_eng: @criterion.houhou_eng, item_type: @criterion.item_type, kijun: @criterion.kijun, kijun_eng: @criterion.kijun_eng } }
      assert_redirected_to criterion_url(@criterion)
    end

    test "should destroy criterion" do
      assert_difference('Criterion.count', -1) do
        delete criterion_url(@criterion)
      end

      assert_redirected_to criterions_url
    end
  end
end
