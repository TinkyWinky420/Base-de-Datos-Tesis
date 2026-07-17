class AdministrativoController < ApplicationController

  before_action :verificar_administrativo

  def index
    @nombres = Nombre.order(:numero_control)
  end

  private

  def verificar_administrativo
    unless session[:rol] == "administrativo"
      redirect_to root_path,
      alert: "No tienes permiso para acceder."
    end
  end

end