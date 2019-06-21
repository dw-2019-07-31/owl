require 'test_helper'

module ReturnEngine
  class ReturnbooksControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @returnbook = return_engine_returnbooks(:one)
    end

    test "should get index" do
      get returnbooks_url
      assert_response :success
    end

    test "should get new" do
      get new_returnbook_url
      assert_response :success
    end

    test "should create returnbook" do
      assert_difference('Returnbook.count') do
        post returnbooks_url, params: { returnbook: { name: @returnbook.name } }
      end

      assert_redirected_to returnbook_url(Returnbook.last)
    end

    test "should show returnbook" do
      get returnbook_url(@returnbook)
      assert_response :success
    end

    test "should get edit" do
      get edit_returnbook_url(@returnbook)
      assert_response :success
    end

    test "should update returnbook" do
      patch returnbook_url(@returnbook), params: { returnbook: { name: @returnbook.name } }
      assert_redirected_to returnbook_url(@returnbook)
    end

    test "should destroy returnbook" do
      assert_difference('Returnbook.count', -1) do
        delete returnbook_url(@returnbook)
      end

      assert_redirected_to returnbooks_url
    end
  end
end
