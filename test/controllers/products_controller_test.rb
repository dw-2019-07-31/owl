require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    @product = products(:one)
    Warden.test_mode!
    #fixtureのoneをテストで利用する
    @user = users( :one )
    #テストでadmin権限を付与し、認可を通す
    @user.add_role :admin 
    login_as(@user, :scope => :user)
  end

  test "should show admin" do
    get rails_admin_path
    assert_response :success
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { catchcopy: @product.catchcopy, code: @product.code, weight_g: @product.weight_g } }
    end

    assert_redirected_to product_url(@product.code)
  end

  test "should show product" do
    get product_url(@product.code)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product.code)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product.code), params: { product: { catchcopy: @product.catchcopy, code: @product.code, weight_g: @product.weight_g } }
    assert_redirected_to product_url(@product.code)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product.code)
    end

    assert_redirected_to products_url
  end

end
