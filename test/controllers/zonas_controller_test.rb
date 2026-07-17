require "test_helper"

class ZonasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get zonas_index_url
    assert_response :success
  end
end
