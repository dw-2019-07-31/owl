require 'test_helper'

module ReturnEngine
  class InputpeopleControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @inputperson = return_engine_inputpeople(:one)
    end

    test "should get index" do
      get inputpeople_url
      assert_response :success
    end

    test "should get new" do
      get new_inputperson_url
      assert_response :success
    end

    test "should create inputperson" do
      assert_difference('Inputperson.count') do
        post inputpeople_url, params: { inputperson: { name: @inputperson.name } }
      end

      assert_redirected_to inputperson_url(Inputperson.last)
    end

    test "should show inputperson" do
      get inputperson_url(@inputperson)
      assert_response :success
    end

    test "should get edit" do
      get edit_inputperson_url(@inputperson)
      assert_response :success
    end

    test "should update inputperson" do
      patch inputperson_url(@inputperson), params: { inputperson: { name: @inputperson.name } }
      assert_redirected_to inputperson_url(@inputperson)
    end

    test "should destroy inputperson" do
      assert_difference('Inputperson.count', -1) do
        delete inputperson_url(@inputperson)
      end

      assert_redirected_to inputpeople_url
    end
  end
end
