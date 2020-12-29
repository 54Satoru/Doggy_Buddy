require 'test_helper'

class PostCControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get post_c_new_url
    assert_response :success
  end

end
