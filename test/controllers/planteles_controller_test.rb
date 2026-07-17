require "test_helper"

class PlantelesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get planteles_index_url
    assert_response :success
  end

  test "should get new" do
    get planteles_new_url
    assert_response :success
  end
end
