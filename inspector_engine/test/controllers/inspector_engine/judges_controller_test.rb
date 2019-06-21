require 'test_helper'

module InspectorEngine
  class JudgesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @judge = inspector_engine_judges(:one)
    end

    test "should get index" do
      get judges_url
      assert_response :success
    end

    test "should get new" do
      get new_judge_url
      assert_response :success
    end

    test "should create judge" do
      assert_difference('Judge.count') do
        post judges_url, params: { judge: { houhou: @judge.houhou, houhou_eng: @judge.houhou_eng } }
      end

      assert_redirected_to judge_url(Judge.last)
    end

    test "should show judge" do
      get judge_url(@judge)
      assert_response :success
    end

    test "should get edit" do
      get edit_judge_url(@judge)
      assert_response :success
    end

    test "should update judge" do
      patch judge_url(@judge), params: { judge: { houhou: @judge.houhou, houhou_eng: @judge.houhou_eng } }
      assert_redirected_to judge_url(@judge)
    end

    test "should destroy judge" do
      assert_difference('Judge.count', -1) do
        delete judge_url(@judge)
      end

      assert_redirected_to judges_url
    end
  end
end
