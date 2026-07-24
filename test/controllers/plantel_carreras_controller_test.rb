require "test_helper"

class PlantelCarrerasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get plantel_carreras_index_url
    assert_response :success
  end
end
