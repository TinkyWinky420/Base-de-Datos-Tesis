require "test_helper"

class NombresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nombre = nombres(:one)
  end

  test "should get index" do
    get nombres_url
    assert_response :success
  end

  test "should get new" do
    get new_nombre_url
    assert_response :success
  end

  test "should create nombre" do
    assert_difference("Nombre.count") do
      post nombres_url, params: { nombre: { descripcion: @nombre.descripcion, titulo: @nombre.titulo } }
    end

    assert_redirected_to nombre_url(Nombre.last)
  end

  test "should show nombre" do
    get nombre_url(@nombre)
    assert_response :success
  end

  test "should get edit" do
    get edit_nombre_url(@nombre)
    assert_response :success
  end

  test "should update nombre" do
    patch nombre_url(@nombre), params: { nombre: { descripcion: @nombre.descripcion, titulo: @nombre.titulo } }
    assert_redirected_to nombre_url(@nombre)
  end

  test "should destroy nombre" do
    assert_difference("Nombre.count", -1) do
      delete nombre_url(@nombre)
    end

    assert_redirected_to nombres_url
  end
end
