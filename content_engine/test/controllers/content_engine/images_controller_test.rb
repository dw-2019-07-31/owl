require 'test_helper'

module ContentEngine
  class ImagesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @image = content_engine_images(:one)
    end

    test "should get index" do
      get images_url
      assert_response :success
    end

    test "should get new" do
      get new_image_url
      assert_response :success
    end

    test "should create image" do
      file = Rack::Test::UploadedFile.new('test/fixtures/imagefiles/testimage.jpg','	image/jpeg')
      post images_url, params: {image:{code: 'code' ,upload_file: file }}
      assert_response :success
    end

    test "should show image" do
      get image_url(@image)
      assert_response :success
    end

    test "should get edit" do
      get edit_image_url(@image)
      assert_response :success
    end

    test "should update image" do
      patch image_url(@image), params: { image: { code: @image.code, extension: @image.extension, filename: @image.filename, imagefile: @image.imagefile } }
      assert_redirected_to image_url(@image)
    end

    test "should destroy image" do
      assert_difference('Image.count', -1) do
        delete image_url(@image)
      end

      assert_redirected_to images_url
    end
  end
end
