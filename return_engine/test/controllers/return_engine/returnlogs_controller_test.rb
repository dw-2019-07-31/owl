require 'test_helper'

module ReturnEngine
  class ReturnlogsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @returnlog = return_engine_returnlogs(:one)
    end

    test "should get index" do
      get returnlogs_url
      assert_response :success
    end

    test "should get new" do
      get new_returnlog_url
      assert_response :success
    end

    test "should create returnlog" do
      assert_difference('Returnlog.count') do
        post returnlogs_url, params: { returnlog: { arrived_date: @returnlog.arrived_date, boxes_count: @returnlog.boxes_count, cutoff_date: @returnlog.cutoff_date, delivery_trader: @returnlog.delivery_trader, input_person: @returnlog.input_person, inquiry_no: @returnlog.inquiry_no, note: @returnlog.note, owner_code: @returnlog.owner_code, owner_name: @returnlog.owner_name, peace_count: @returnlog.peace_count, return_book: @returnlog.return_book, returned_date: @returnlog.returned_date, sales_person: @returnlog.sales_person, status: @returnlog.status } }
      end

      assert_redirected_to returnlog_url(Returnlog.last)
    end

    test "should show returnlog" do
      get returnlog_url(@returnlog)
      assert_response :success
    end

    test "should get edit" do
      get edit_returnlog_url(@returnlog)
      assert_response :success
    end

    test "should update returnlog" do
      patch returnlog_url(@returnlog), params: { returnlog: { arrived_date: @returnlog.arrived_date, boxes_count: @returnlog.boxes_count, cutoff_date: @returnlog.cutoff_date, delivery_trader: @returnlog.delivery_trader, input_person: @returnlog.input_person, inquiry_no: @returnlog.inquiry_no, note: @returnlog.note, owner_code: @returnlog.owner_code, owner_name: @returnlog.owner_name, peace_count: @returnlog.peace_count, return_book: @returnlog.return_book, returned_date: @returnlog.returned_date, sales_person: @returnlog.sales_person, status: @returnlog.status } }
      assert_redirected_to returnlog_url(@returnlog)
    end

    test "should destroy returnlog" do
      assert_difference('Returnlog.count', -1) do
        delete returnlog_url(@returnlog)
      end

      assert_redirected_to returnlogs_url
    end
  end
end
