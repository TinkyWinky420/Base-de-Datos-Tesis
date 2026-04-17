require "test_helper"

class HistorialControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get historial_index_url
    assert_response :success
  end
end
