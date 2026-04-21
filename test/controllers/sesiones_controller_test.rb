require "test_helper"

class SesionesControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get sesiones_login_url
    assert_response :success
  end

  test "should get procesar_login" do
    get sesiones_procesar_login_url
    assert_response :success
  end

  test "should get logout" do
    get sesiones_logout_url
    assert_response :success
  end
end
