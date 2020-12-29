require 'test_helper'

class PostSControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get post_s_new_url
    assert_response :success
  end

end
