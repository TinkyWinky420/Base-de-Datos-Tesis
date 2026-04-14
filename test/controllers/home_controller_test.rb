require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index}" do
    get home_index}_url
    assert_response :success
  end
end
