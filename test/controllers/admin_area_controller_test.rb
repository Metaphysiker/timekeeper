require "test_helper"

class AdminAreaControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get admin_area_users_url
    assert_response :success
  end
end
