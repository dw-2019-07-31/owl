require 'test_helper'

module InspectorEngine
  class NeedlesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @needle = inspector_engine_needles(:one)
    end

    test "should get index" do
      get needles_url
      assert_response :success
    end

    test "should get new" do
      get new_needle_url
      assert_response :success
    end

    test "should create needle" do
      assert_difference('Needle.count') do
        post needles_url, params: { needle: { basho: @needle.basho, basho_eng: @needle.basho_eng, cost: @needle.cost, houhou: @needle.houhou, houhou_eng: @needle.houhou_eng } }
      end

      assert_redirected_to needle_url(Needle.last)
    end

    test "should show needle" do
      get needle_url(@needle)
      assert_response :success
    end

    test "should get edit" do
      get edit_needle_url(@needle)
      assert_response :success
    end

    test "should update needle" do
      patch needle_url(@needle), params: { needle: { basho: @needle.basho, basho_eng: @needle.basho_eng, cost: @needle.cost, houhou: @needle.houhou, houhou_eng: @needle.houhou_eng } }
      assert_redirected_to needle_url(@needle)
    end

    test "should destroy needle" do
      assert_difference('Needle.count', -1) do
        delete needle_url(@needle)
      end

      assert_redirected_to needles_url
    end
  end
end
