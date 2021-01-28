require 'test_helper'

class FavoriteSittersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_sitters_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_sitters_destroy_url
    assert_response :success
  end

end
