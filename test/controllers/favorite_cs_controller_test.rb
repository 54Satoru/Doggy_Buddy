require 'test_helper'

class FavoriteCsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_cs_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_cs_destroy_url
    assert_response :success
  end

end
