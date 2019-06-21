require 'test_helper'

class NewProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @new_product = new_products(:one)
  end

  test "should get index" do
    get new_products_url
    assert_response :success
  end

  test "should get new" do
    get new_new_product_url
    assert_response :success
  end

  test "should create new_product" do
    assert_difference('NewProduct.count') do
      post new_products_url, params: { new_product: {  } }
    end

    assert_redirected_to new_product_url(NewProduct.last)
  end

  test "should show new_product" do
    get new_product_url(@new_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_new_product_url(@new_product)
    assert_response :success
  end

  test "should update new_product" do
    patch new_product_url(@new_product), params: { new_product: {  } }
    assert_redirected_to new_product_url(@new_product)
  end

  test "should destroy new_product" do
    assert_difference('NewProduct.count', -1) do
      delete new_product_url(@new_product)
    end

    assert_redirected_to new_products_url
  end
end
