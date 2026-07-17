require "test_helper"

class EstadisticasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estadisticas_index_url
    assert_response :success
  end
end
