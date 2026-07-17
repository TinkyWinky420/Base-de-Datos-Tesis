require "test_helper"

class AdministrativoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrativo_index_url
    assert_response :success
  end
end
