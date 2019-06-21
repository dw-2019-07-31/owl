require 'test_helper'

module ContentEngine
  class FiletagsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @filetag = content_engine_filetags(:one)
    end

    test "should get index" do
      get filetags_url
      assert_response :success
    end

    test "should get new" do
      get new_filetag_url
      assert_response :success
    end

    test "should create filetag" do
      assert_difference('Filetag.count') do
        post filetags_url, params: { filetag: { filename: @filetag.filename, tag: @filetag.tag } }
      end

      assert_redirected_to filetag_url(Filetag.last)
    end

    test "should show filetag" do
      get filetag_url(@filetag)
      assert_response :success
    end

    test "should get edit" do
      get edit_filetag_url(@filetag)
      assert_response :success
    end

    test "should update filetag" do
      patch filetag_url(@filetag), params: { filetag: { filename: @filetag.filename, tag: @filetag.tag } }
      assert_redirected_to filetag_url(@filetag)
    end

    test "should destroy filetag" do
      assert_difference('Filetag.count', -1) do
        delete filetag_url(@filetag)
      end

      assert_redirected_to filetags_url
    end
  end
end
