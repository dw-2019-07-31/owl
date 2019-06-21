require 'test_helper'

module InspectorEngine
  class InspectionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @inspection = inspector_engine_inspections(:one)
    end

    test "should get index" do
      get inspections_url
      assert_response :success
    end

    test "should get new" do
      get new_inspection_url
      assert_response :success
    end

    test "should create inspection" do
      assert_difference('Inspection.count') do
        post inspections_url, params: { inspection: { basho: @inspection.basho, basho_eng: @inspection.basho_eng, code: @inspection.code, cost: @inspection.cost, houhou: @inspection.houhou, houhou_eng: @inspection.houhou_eng } }
      end

      assert_redirected_to inspection_url(Inspection.last)
    end

    test "should show inspection" do
      get inspection_url(@inspection)
      assert_response :success
    end

    test "should get edit" do
      get edit_inspection_url(@inspection)
      assert_response :success
    end

    test "should update inspection" do
      patch inspection_url(@inspection), params: { inspection: { basho: @inspection.basho, basho_eng: @inspection.basho_eng, code: @inspection.code, cost: @inspection.cost, houhou: @inspection.houhou, houhou_eng: @inspection.houhou_eng } }
      assert_redirected_to inspection_url(@inspection)
    end

    test "should destroy inspection" do
      assert_difference('Inspection.count', -1) do
        delete inspection_url(@inspection)
      end

      assert_redirected_to inspections_url
    end
  end
end
